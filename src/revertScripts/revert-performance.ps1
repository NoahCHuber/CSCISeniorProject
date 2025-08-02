# revert-performance.ps1
# SwiftEdge Security - Performance Reversal Module (with logging)

# ==============
# Logging Setup
# ==============
$logTime = Get-Date -Format "yyyyMMdd_HHmmss"
$moduleName = "RevertPerformance"
$logFolder = Join-Path $env:USERPROFILE "Documents\SwiftEdgeLogs"
$logPath = Join-Path $logFolder "SwiftEdgeLog_${logTime}_${moduleName}.txt"

if (-not (Test-Path $logFolder)) {
    New-Item -ItemType Directory -Path $logFolder -Force | Out-Null
}

function Log {
    param ([string]$Message)
    Write-Host $Message
    Add-Content -Path $logPath -Value $Message
}

Log "[${moduleName}] Reverting performance optimizations..."

# Revert to Balanced power plan
Log "Reverting power plan to Balanced..."

try {
    $balancedGUID = (powercfg -list | Select-String "Balanced").ToString().Split()[3]
    powercfg -setactive $balancedGUID
    Log "Balanced power plan restored."
} catch {
    Log "Error setting Balanced power plan: $($_.Exception.Message)"
}

# Re-enable essential services
$services = @("SysMain", "WSearch", "DiagTrack")
foreach ($svc in $services) {
    Log "Re-enabling service: $svc"
    try {
        Set-Service -Name $svc -StartupType Automatic
        Start-Service -Name $svc -ErrorAction SilentlyContinue
        Log "$svc re-enabled successfully."
    } catch {
        Log ("Error re-enabling ${svc}: $($_.Exception.Message)")
    }
}

# Re-enable background apps
try {
    $regBA = "HKCU:\Software\Microsoft\Windows\CurrentVersion\BackgroundAccessApplications"
    if (-not (Test-Path $regBA)) {
        New-Item -Path $regBA -Force | Out-Null
    }
    Set-ItemProperty -Path $regBA -Name "GlobalUserDisabled" -Value 0 -Force
    Log "Background apps re-enabled."
} catch {
    Log "Error re-enabling background apps: $($_.Exception.Message)"
}

# Re-enable animations and transparency
try {
    Set-ItemProperty -Path "HKCU:\Control Panel\Desktop\WindowMetrics" -Name "MinAnimate" -Value 1
    $personalizePath = "HKCU:\Software\Microsoft\Windows\CurrentVersion\Themes\Personalize"
    if (-not (Test-Path $personalizePath)) {
        New-Item -Path $personalizePath -Force | Out-Null
    }
    Set-ItemProperty -Path $personalizePath -Name "EnableTransparency" -Value 1
    Log "Animations and transparency re-enabled."
} catch {
    Log "Error re-enabling animations/transparency: $($_.Exception.Message)"
}

# Re-enable Windows Tips
try {
    $path = "HKCU:\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager"
    if (-not (Test-Path $path)) { New-Item -Path $path -Force | Out-Null }
    Set-ItemProperty -Path $path -Name "SoftLandingEnabled" -Value 1 -Force
    Set-ItemProperty -Path $path -Name "SubscribedContent-310093Enabled" -Value 1 -Force
    Log "Windows Tips re-enabled."
} catch {
    Log "Error re-enabling Windows Tips: $($_.Exception.Message)"
}

# Re-enable hibernation
try {
    powercfg -h on
    Log "Hibernation re-enabled."
} catch {
    Log "Error re-enabling hibernation: $($_.Exception.Message)"
}

# Revert startup delay
try {
    $serializePath = "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Serialize"
    if (Test-Path $serializePath) {
        Remove-ItemProperty -Path $serializePath -Name "StartupDelayInMSec" -ErrorAction SilentlyContinue
        Log "Startup delay restored to default."
    }
} catch {
    Log "Error restoring startup delay: $($_.Exception.Message)"
}

Log "[${moduleName}] Reversion complete."
