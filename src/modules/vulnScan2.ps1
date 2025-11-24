# NVD Vulnerability Scanner (Yearly Feed)
# Uses local NVD JSON feed from NIST
# Downloads at most once per day (per year)
# Matches installed applications vs CVE version ranges in the NVD data

function Run-VulnScan {
    # StringBuilder used to collect all output text (for GUI/log display)
	$output = New-Object System.Text.StringBuilder

    # Helper function to append a line of text to the StringBuilder
    function Out-GUI {
		param($m)
        $null = $output.AppendLine($m)
	}

	# Stop on errors so we can catch failures cleanly
	$ErrorActionPreference = 'Stop'

	# =========================
	# Paths & URLs
	# =========================

    # Use current year feed from NVD
	$year   = (Get-Date).Year
	$feedUrl = "https://nvd.nist.gov/feeds/json/cve/2.0/nvdcve-2.0-$year.json.gz"

    # Local cache directory and filenames for compressed and extracted JSON
	$localRoot = "$env:LOCALAPPDATA\SwiftEdge\NVD"
	$gzPath    = Join-Path $localRoot "nvdcve-$year.json.gz"
	$jsonPath  = Join-Path $localRoot "nvdcve-$year.json"

    # Create cache folder if it doesn't exist
	if (-not (Test-Path $localRoot)) {
		New-Item -ItemType Directory -Path $localRoot | Out-Null
	}

	# =========================
	# Local Cache Check
	# =========================

	$needDownload = $false

    # If no JSON exists for this year, we must download
	if (-not (Test-Path $jsonPath)) {
		Out-GUI "No local NVD JSON for $year. Download needed."
		$needDownload = $true
	}
    # If existing JSON is older than 1 day, refresh it
	elseif ((Get-Item $jsonPath).LastWriteTime -lt (Get-Date).AddDays(-1)) {
		Out-GUI "Local JSON older than 1 day. Refreshing."
		$needDownload = $true
	}
    # Otherwise, reuse local cached file
	else {
		Out-GUI " Using local NVD JSON for $year."
	}

	# =========================
	# Download + Extract if Needed
	# =========================

	if ($needDownload) {
		Out-GUI "`n Downloading NVD feed: $feedUrl"

        # Download the yearly NVD JSON.gz file
		Invoke-WebRequest `
			-Uri $feedUrl `
			-Headers @{ "User-Agent" = "Mozilla/5.0" } `
			-OutFile $gzPath

		Out-GUI "Download complete. Extracting..."

        # Decompress the .gz file into plain JSON
		$gzStream  = [System.IO.File]::OpenRead($gzPath)
		$gzip   = New-Object System.IO.Compression.GzipStream($gzStream, [IO.Compression.CompressionMode]::Decompress)

        # NOTE: here $output is a FileStream used for writing the JSON file
        # (not the StringBuilder defined at the top of the function)
		$output = [System.IO.File]::Create($jsonPath)
		$gzip.CopyTo($output)

		$gzip.Close()
		$output.Close()
		$gzStream.Close()

		Out-GUI "Extracted JSON to $jsonPath"
	}

	# =========================
	# Load JSON into memory
	# =========================

	Out-GUI "`n Loading CVE JSON..."
    # Read JSON file and convert to a PowerShell object
	$cveData = Get-Content $jsonPath -Raw | ConvertFrom-Json
	$vulns   = $cveData.vulnerabilities
	Out-GUI "Loaded $($vulns.Count) CVEs for $year`n"

	# =========================
	# Installed Applications
	# =========================

    # Function to pull installed apps (name + version) from common registry locations
	function Get-InstalledApps {
		$paths = @(
			'HKLM:\Software\Microsoft\Windows\CurrentVersion\Uninstall\*',
			'HKLM:\Software\Wow6432Node\Microsoft\Windows\CurrentVersion\Uninstall\*',
			'HKCU:\Software\Microsoft\Windows\CurrentVersion\Uninstall\*'
		)

        # Filter entries that have both DisplayName and DisplayVersion
		Get-ItemProperty -Path $paths -ErrorAction SilentlyContinue |
			Where-Object { $_.DisplayName -and $_.DisplayVersion } |
			Select-Object @{n='Name';e={$_.DisplayName}}, @{n='Version';e={$_.DisplayVersion}} -Unique
	}

	$apps = Get-InstalledApps
	Out-GUI "Found $($apps.Count) installed apps.`n"

	# =========================
	# Version Handling Helpers
	# =========================

    # Normalize-Version: parse version string into an integer array (major.minor.build...)
	function Normalize-Version {
		param([string]$Version)

		# Ignore blank or meaningless version strings
		if ([string]::IsNullOrWhiteSpace($Version) -or $Version -in @('*','-')) {
			return $null
		}

		$v = $Version.Trim()

		# Drop build metadata (e.g., 1.2.3+build45 -> 1.2.3)
		if ($v -like '*+*') { $v = $v.Split('+')[0] }

		$parts = New-Object System.Collections.Generic.List[int]

        # Split on dots and keep numeric components
		foreach ($p in $v.Split('.')) {
			if ($p -match '^\d+$') {
				[void]$parts.Add([int]$p)
			}
			else {
				# For weird tokens, strip non-digits and keep digits only
				$nums = ($p -replace '[^\d]', '')
				if ($nums -match '^\d+$') {
					[void]$parts.Add([int]$nums)
				}
			}
		}

		if ($parts.Count -eq 0) {
			return $null
		}

        # Return as an array of integers
		,$parts.ToArray()
	}

    # Compare-Version: compare two version strings
    # Returns -1 if V1 < V2, 0 if equal/unknown, 1 if V1 > V2
	function Compare-Version {
		param(
			[string]$V1,
			[string]$V2
		)

		$a = Normalize-Version $V1
		$b = Normalize-Version $V2

        # If either can't be parsed, treat as equal (no strict ordering)
		if ($null -eq $a -and $null -eq $b) { return 0 }
		if ($null -eq $a) { return 0 }
		if ($null -eq $b) { return 0 }

		$max = [Math]::Max($a.Length, $b.Length)

        # Pad shorter version arrays with zeros (e.g., 1.2 vs 1.2.0)
		while ($a.Length -lt $max) { $a += 0 }
		while ($b.Length -lt $max) { $b += 0 }

        # Compare component by component
		for ($i=0; $i -lt $max; $i++) {
			if ($a[$i] -lt $b[$i]) { return -1 }
			if ($a[$i] -gt $b[$i]) { return 1 }
		}
		return 0
	}

    # Test-VersionInRange: checks if Target version falls inside a vulnerable range
	function Test-VersionInRange {
		param(
			[string]$Target,
			[string]$StartIncluding,
			[string]$StartExcluding,
			[string]$EndIncluding,
			[string]$EndExcluding
		)

		if ([string]::IsNullOrWhiteSpace($Target)) { return $false }

		# start including: target >= start
		if ($StartIncluding) {
			if ((Compare-Version $Target $StartIncluding) -lt 0) {
				return $false
			}
		}

		# start excluding: target > start
		if ($StartExcluding) {
			if ((Compare-Version $Target $StartExcluding) -le 0) {
				return $false
			}
		}

		# end including: target <= end
		if ($EndIncluding) {
			if ((Compare-Version $Target $EndIncluding) -gt 0) {
				return $false
			}
		}

		# end excluding: target < end
		if ($EndExcluding) {
			if ((Compare-Version $Target $EndExcluding) -ge 0) {
				return $false
			}
		}

		return $true
	}

	# =========================
	# Vulnerability Matching
	# =========================

    # This will store all matched vulnerabilities per app
	$findings = @()

	# Progress bar for scanning CVEs
	$progress = 0
	$totalVulns = $vulns.Count
	Out-GUI "Scanning CVEs against installed apps..."

    # Loop through every CVE entry in the NVD feed
	foreach ($v in $vulns) {
		$progress++
        # Show progress every 1000 CVEs
		if ($progress % 1000 -eq 0) {
			Write-Progress -Activity "Scanning CVEs" -Status "$progress / $totalVulns" -PercentComplete ($progress / $totalVulns * 100)
		}

        # Each CVE has configurations with CPE matches (affected products)
		foreach ($config in $v.cve.configurations) {
			foreach ($node in $config.nodes) {
				foreach ($m in $node.cpeMatch) {
					# Only consider entries marked vulnerable
					if (-not $m.vulnerable) { continue }

					$criteria = $m.criteria
					if (-not $criteria) { continue }

					# CPE format: cpe:2.3:a:vendor:product:version:...
					$parts = $criteria.Split(':')
					if ($parts.Count -lt 5) { continue }

					$vendor  = $parts[3]
					$product = $parts[4]
					$vendorLc = $vendor.ToLower()
					$productLc = $product.ToLower()

                    # Vulnerable version boundaries from NVD
					$startInc = $m.versionStartIncluding
					$startExc = $m.versionStartExcluding
					$endInc   = $m.versionEndIncluding
					$endExc   = $m.versionEndExcluding

					# Now check against each installed app
					foreach ($app in $apps) {
						$name    = $app.Name
						$version = $app.Version
						$nameLc  = $name.ToLower()

						# Stricter name match:
                        # require both vendor AND product strings to appear in the app name
						if ($nameLc -notlike "*$vendorLc*" -or $nameLc -notlike "*$productLc*") { continue }

                        # If app version not in vulnerable range, skip
						if (-not (Test-VersionInRange -Target $version `
									-StartIncluding $startInc `
									-StartExcluding $startExc `
									-EndIncluding $endInc `
									-EndExcluding $endExc)) {
							continue
						}

						# At this point: app name roughly matches CPE and its version is vulnerable

                        # Get English description for the CVE
						$desc = ($v.cve.descriptions | Where-Object { $_.lang -eq 'en' } | Select-Object -First 1).value

                        # Get CVSS v3.1 or v3.0 metrics if available
						$cvss = $null
						if ($v.cve.metrics.cvssMetricV31) {
							$cvss = $v.cve.metrics.cvssMetricV31[0].cvssData
						}
						elseif ($v.cve.metrics.cvssMetricV30) {
							$cvss = $v.cve.metrics.cvssMetricV30[0].cvssData
						}

                        # Extract severity and base score
						$severity = if ($cvss) { $cvss.baseSeverity } else { 'UNKNOWN' }
						$score    = if ($cvss) { $cvss.baseScore } else { 0.0 }

                        # Record a finding object with app + CVE details
						$findings += [pscustomobject]@{
							AppName       = $name
							Installed     = $version
							CveId         = $v.cve.id
							Severity      = $severity
							Score         = $score
							VersionStartI = $startInc
							VersionStartE = $startExc
							VersionEndI   = $endInc
							VersionEndE   = $endExc
							Description   = $desc
						}
					}
				}
			}
		}
	}

	# Complete the progress bar
	Write-Progress -Activity "Scanning CVEs" -Completed

	# =========================
	# Summarize & Display Top 5 Most Vulnerable Apps
	# =========================

	if (-not $findings -or $findings.Count -eq 0) {
		Out-GUI "`n==========================="
		Out-GUI " Vulnerability Results"
		Out-GUI "==========================="
		Out-GUI "No vulnerabilities detected based on $year NVD feed!"
	}
	else {
        # Map text severity to numeric rank for easier sorting
		$severityRank = @{
			'CRITICAL' = 4
			'HIGH'     = 3
			'MEDIUM'   = 2
			'LOW'      = 1
			'UNKNOWN'  = 0
		}

		# Build one summary row per application
		$appSummaries = foreach ($group in ($findings | Group-Object AppName)) {

			$appName = $group.Name
            # Installed version (same across all findings for this app)
			$installedVersion = ($group.Group | Select-Object -First 1).Installed

			# Sort all vulnerabilities for this app:
            # 1) by severity rank DESC
            # 2) by CVSS score DESC
			$sortedVulns = $group.Group |
				Sort-Object `
					@{Expression = { $severityRank[$_.Severity] }; Descending = $true}, `
					@{Expression = { $_.Score }; Descending = $true}

			# Worst vulnerability (highest severity / score) for this app
			$worst = $sortedVulns | Select-Object -First 1

			if (-not $worst) { continue }

			# Top 5 CVEs for this app (unique by CVE ID, highest severity/score first)
			$topCves = $sortedVulns |
				Select-Object CveId, Severity, Score -Unique |
				Select-Object -First 5

			[pscustomobject]@{
				AppName         = $appName
				Version         = $installedVersion
				HighestSeverity = $worst.Severity
				HighestScore    = $worst.Score
				SeverityRank    = $severityRank[$worst.Severity]
				TopCves         = $topCves
			}
		}

		# Sort apps by their worst vulnerability and take the top 5
		$top5Apps = $appSummaries |
			Sort-Object `
				@{Expression = { $_.SeverityRank }; Descending = $true}, `
				@{Expression = { $_.HighestScore }; Descending = $true}, `
				@{Expression = { $_.AppName }} |
			Select-Object -First 5

		Out-GUI "`n==========================="
		Out-GUI "  TOP 5 MOST VULNERABLE APPS"
		Out-GUI "==========================="
		Out-GUI "Ranked by: severity rank CVSS score"
		
        # Print a short report for each of the top 5 apps
		foreach ($app in $top5Apps) {
			Out-GUI ""
			Out-GUI "$($app.AppName)  (Version: $($app.Version))"
			Out-GUI "  Highest Severity: $($app.HighestSeverity)  Rank: $($app.SeverityRank)  Score: $($app.HighestScore)"
			Out-GUI "  Top CVEs:"
			foreach ($cve in $app.TopCves) {
				Out-GUI "    - $($cve.CveId)  [$($cve.Severity) $($cve.Score)]"
			}
		}

		# =========================
		# Simple Recommended Actions Section
		# =========================
		Out-GUI "`n==========================="
		Out-GUI " Recommended Actions"
		Out-GUI "==========================="

        # Check whether any top-5 app has HIGH or CRITICAL vulns
		$hasHigh = $top5Apps | Where-Object { $_.HighestSeverity -in @('CRITICAL','HIGH') }

		if ($hasHigh) {
			Out-GUI "- Prioritize updating or patching apps with severity rank (HIGH / CRITICAL)."
		}
		Out-GUI "- Use the official updater or vendor website for each listed application."
		Out-GUI "- If an app is unused, consider uninstalling it to reduce attack surface."
		Out-GUI "- After applying updates, rerun this scanner to confirm the vulnerabilities are reduced."
	}

    # Return all accumulated output text as a single string (useful for GUI/log window)
	return $output.ToString()
}
