param(
    [string]$ApiKey = "",                    # Optional: NVD API key (request from nvd.nist.gov)
    [int]$MaxResultsPerProduct = 10,         # max CVEs fetched per product
    [int]$ThrottleMs = 700,                  # base throttle between requests (ms). With API key you can lower it.
    [string]$OutputCsv = "CVE_Report.csv",   # output file
    [switch]$IncludeLowSeverity,              # include CVSS < 4.0 results if set
	[switch]$ShowProgress
)

# -------------------------
# Helper / Config
# -------------------------
$baseUrl = "https://services.nvd.nist.gov/rest/json/cves/2.0"
$headers = @{}
if ($ApiKey -and $ApiKey.Trim() -ne "") {
    # API key is passed as query param, but also safe to send as header for some setups
    $headers["apiKey"] = $ApiKey
}

# Rate-limits: public = ~5 requests / 30s, with API key ~50/30s (we'll be conservative)
# See NVD docs & community guidance for exact numbers. Use throttling accordingly. :contentReference[oaicite:1]{index=1}

function Invoke-NvdRequest {
    param(
        [string]$Url,
        [hashtable]$Headers,
        [int]$MaxAttempts = 4
    )
    $attempt = 0
    while ($attempt -lt $MaxAttempts) {
        try {
            $attempt++
            $resp = Invoke-RestMethod -Uri $Url -Headers $Headers -Method Get -ErrorAction Stop
            return $resp
        } catch {
            # Simple exponential backoff with jitter
            $wait = [math]::Round(([math]::Pow(2, $attempt) * ($ThrottleMs / 1000)) + (Get-Random -Minimum 0 -Maximum 1), 2)
            Write-Verbose "Request failed (attempt $attempt). Waiting $wait s before retry. Error: $($_.Exception.Message)"
            Start-Sleep -Seconds $wait
        }
    }
    throw "Failed to fetch $Url after $MaxAttempts attempts."
}

# -------------------------
# Get Installed Software
# -------------------------
function Get-InstalledSoftware {
    $software = @()

    # 1) From registry (64-bit & 32-bit HKLM and HKCU)
    $regPaths = @(
        "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\*",
        "HKLM:\SOFTWARE\WOW6432Node\Microsoft\Windows\CurrentVersion\Uninstall\*",
        "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\*"
    )
    foreach ($p in $regPaths) {
        try {
            Get-ItemProperty -Path $p -ErrorAction SilentlyContinue | ForEach-Object {
                if ($_.DisplayName) {
                    $software += [PSCustomObject]@{
                        Name = $_.DisplayName
                        Version = ($_.DisplayVersion -as [string]) -replace "`r`n",""
                        Source = "Registry"
                    }
                }
            }
        } catch { }
    }

    # 2) If WinGet is available, use it (may provide better product names)
    try {
        if (Get-Command winget -ErrorAction SilentlyContinue) {
            $wingetList = winget list --source winget 2>$null | Select-String -Pattern "^\S" -Quiet:$false
            if ($wingetList) {
                # Use winget list --id --name? Fallback parsing:
                $raw = winget list 2>$null
                $lines = $raw | Select-Object -Skip 1
                foreach ($line in $lines) {
                    # crude parse: columns separated by 2+ spaces
                    $parts = ($line -split "\s{2,}") | ForEach-Object { $_.Trim() } | Where-Object { $_ -ne "" }
                    if ($parts.Count -ge 1) {
                        $name = $parts[0]
                        $ver = if ($parts.Count -ge 2) { $parts[1] } else { "" }
                        $software += [PSCustomObject]@{ Name = $name ; Version = $ver ; Source = "WinGet" }
                    }
                }
            }
        }
    } catch { }

    # Deduplicate by name (take first occurrence)
    $software = $software | Where-Object { $_.Name -and ($_.Name.Trim() -ne "") } |
                Group-Object -Property { $_.Name.Trim() } |
                ForEach-Object { $_.Group[0] }

    return $software
}

# -------------------------
# Query NVD for a product name using keywordSearch
# -------------------------
function Query-NvdByKeyword {
    param(
        [string]$ProductName,
        [int]$MaxResults = 10
    )

    # Build query - encode for URL
    $k = [System.Web.HttpUtility]::UrlEncode($ProductName)
    $resultsPerPage = [math]::Min($MaxResults, 200)
    $url = "$baseUrl?keywordSearch=$k&resultsPerPage=$resultsPerPage"

    # Append apiKey param if provided (some prefer query param)
    if ($ApiKey -and $ApiKey.Trim() -ne "") {
        $url += "&apiKey=$([System.Web.HttpUtility]::UrlEncode($ApiKey))"
    }

    # Throttle to avoid hitting NVD limits
    Start-Sleep -Milliseconds $ThrottleMs

    $resp = Invoke-NvdRequest -Url $url -Headers $headers

    return $resp
}

# -------------------------
# Normalize and simplify CVE item parsing
# -------------------------
function Parse-CveItems {
    param($nvdResponse, $productName)
    $out = @()
    if (-not $nvdResponse) { return $out }
    if ($null -eq $nvdResponse.vulnerabilities) { return $out }

    foreach ($v in $nvdResponse.vulnerabilities) {
        # NVD v2 structure: each entry has cve and cve.id etc. Handle missing fields gracefully.
        $cve = $v.cve
        $id = $cve.id
        $summary = ($cve.descriptions | Where-Object { $_.lang -eq 'en' } | Select-Object -First 1 -ExpandProperty value) -join " "
        # CVSS vectors may be in metrics.*.cvssData or metrics.cvssMetricVersions - keep simple
        $cvssScore = $null
        if ($cve.metrics) {
            # try CVSS v3 then v2
            try {
                if ($cve.metrics.cvssMetricV30) {
                    $cvssScore = $cve.metrics.cvssMetricV30[0].cvssData.baseScore
                } elseif ($cve.metrics.cvssMetricV31) {
                    $cvssScore = $cve.metrics.cvssMetricV31[0].cvssData.baseScore
                } elseif ($cve.metrics.cvssMetricV2) {
                    $cvssScore = $cve.metrics.cvssMetricV2[0].cvssData.baseScore
                }
            } catch { $cvssScore = $null }
        }

        $published = $cve.published
        $references = @()
        if ($cve.references) {
            $references = $cve.references | ForEach-Object { $_.url } | Where-Object { $_ } | Select-Object -Unique
        }

        $out += [PSCustomObject]@{
            ProductQueried = $productName
            CVE_ID = $id
            Summary = $summary
            CVSS_BaseScore = $cvssScore
            PublishedDate = $published
            References = ($references -join "; ")
        }
    }

    return $out
}

# -------------------------
# Main
# -------------------------
Write-Host "Scanning installed software and querying NVD..." -ForegroundColor Cyan

# Show heartbeat while software list loads
$timer = [System.Diagnostics.Stopwatch]::StartNew()
Start-Job -Name "Heartbeat" -ScriptBlock {
    while ($true) {
        Write-Host ("[INFO] Still scanning registry... {0:N0}s elapsed" -f $using:timer.Elapsed.TotalSeconds) -ForegroundColor DarkGray
        Start-Sleep -Seconds 5
    }
} | Out-Null

$installed = Get-InstalledSoftware

# Stop heartbeat once list is loaded
Stop-Job -Name "Heartbeat" -Force | Out-Null
Remove-Job -Name "Heartbeat" -Force | Out-Null
Write-Host ("Found {0} installed programs. Beginning CVE lookup..." -f $installed.Count) -ForegroundColor Yellow

if (-not $installed -or $installed.Count -eq 0) {
    Write-Warning "No installed software found. You can also pass a list of product names manually by piping input."
}

$allFindings = @()
$counter = 0
$Total = $installed.Count
$sw = [System.Diagnostics.Stopwatch]::StartNew()

$counter = 0
foreach ($pkg in $installed) {
    $counter++
    $name = $pkg.Name.Trim()

    if ($ShowProgress) {
        # percent complete
        $pct = if ($Total -gt 0) { [math]::Floor(($counter / $Total) * 100) } else { 0 }

        # simple ETA (seconds remaining) based on elapsed/processed
        $avgSecPerItem = if ($counter -gt 0) { $sw.Elapsed.TotalSeconds / $counter } else { 1 }
        $etaSec = [int]([math]::Ceiling(($Total - $counter) * [math]::Max($avgSecPerItem, ($ThrottleMs/1000) + 0.5)))

        Write-Progress `
            -Activity "Querying NVD (rate-limited)" `
            -Status    ("[{0}/{1}] {2}" -f $counter, $Total, $name) `
            -PercentComplete $pct `
            -SecondsRemaining $etaSec
    } else {
        Write-Host "[$counter/$Total] Querying NVD for: $name"
    }

    try {
        $resp   = Query-NvdByKeyword -ProductName $name -MaxResults $MaxResultsPerProduct
        $parsed = Parse-CveItems -nvdResponse $resp -productName $name

        if (-not $IncludeLowSeverity) {
            $parsed = $parsed | Where-Object {
                if (-not $_.CVSS_BaseScore) { $true } else { [double]$_.CVSS_BaseScore -ge 4.0 }
            }
        }

        $allFindings += $parsed
    } catch {
        Write-Warning "Failed to query NVD for ${name}: $($_.Exception.Message)"
    }
}

# complete the progress bar when done
if ($ShowProgress) { Write-Progress -Activity "Querying NVD (rate-limited)" -Completed }


# Deduplicate by CVE ID
$uniqueFindings = $allFindings | Group-Object -Property CVE_ID | ForEach-Object { $_.Group[0] }

# Export
if ($uniqueFindings.Count -gt 0) {
    $uniqueFindings | Select-Object ProductQueried, CVE_ID, CVSS_BaseScore, PublishedDate, Summary, References |
        Export-Csv -Path $OutputCsv -NoTypeInformation -Encoding UTF8
    Write-Host "Exported $($uniqueFindings.Count) unique CVE findings to $OutputCsv" -ForegroundColor Green
} else {
    Write-Host "No CVE results found for scanned software (after filtering)." -ForegroundColor Yellow
}

# Print brief top-5 summary
$top = $uniqueFindings | Sort-Object @{Expression={ if ($_.CVSS_BaseScore) {[double]$_.CVSS_BaseScore} else {0} } } -Descending | Select-Object -First 5
if ($top) {
    Write-Host ""
    Write-Host "Top findings (by base score):"
    $top | ForEach-Object {
        Write-Host ("{0}  |  {1}  |  {2}" -f $_.CVE_ID, ($_.CVSS_BaseScore -as [string]), $_.ProductQueried)
        Write-Host ("   {0}" -f ($_.Summary -replace "`r`n"," ")) -ForegroundColor DarkGray
    }
}

Write-Host "Scan complete."