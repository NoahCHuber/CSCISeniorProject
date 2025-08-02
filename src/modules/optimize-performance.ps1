# optimize-performance.ps1
# SwiftEdge Security - Performance Optimization Module (with logging)

# ==============
# Logging Setup
# ==============
$logTime = Get-Date -Format "yyyyMMdd_HHmmss"
$moduleName = "OptimizePerformance"
$logFolder = Join-Path $env:USERPROFILE "Documents\SwiftEdgeLogs"
$logPath = Join-Path $logFolder "SwiftEdgeLog_${logTime}_${moduleName}.txt"

# Create the folder if it doesn't exist
if (-not (Test-Path $logFolder)) {
    New-Item -ItemType Directory -Path $logFolder -Force | Out-Null
}

# Simple logging function
function Log {
    param ([string]$Message)
    Write-Host $Message
    Add-Content -Path $logPath -Value $Message
}

Log "[${moduleName}] Starting Performance Optimization Module..."

Log "[Performance Module] Starting optimization..."

# Enable Ultimate Performance / Fallback to High Performance
Log "Setting Ultimate Performance plan..."
Log "Note: You may see 'Attempted to write to unsupported setting' - this is normal and does not affect functionality."

# Attempt to duplicate the Ultimate Performance plan (harmless if already exists)
powercfg -duplicatescheme e9a42b02-d5df-448d-aa00-03f14749eb61 | Out-Null

# Try to activate it
try {
    powercfg -setactive e9a42b02-d5df-448d-aa00-03f14749eb61
    Log "Ultimate Performance plan is now active."
} catch {
    Log "Failed to activate Ultimate Performance plan. Falling back to High Performance..."
    try {
        $highPerfGUID = (powercfg -list | Select-String "High performance").ToString().Split()[3]
        powercfg -setactive $highPerfGUID
        Log "High Performance plan enabled."
    } catch {
        Log "Unable to activate any performance plan: $($_.Exception.Message)"
    }
}
# Disable non-essential services (SysMain, Windows Search, DiagTrack)
$services = @("SysMain", "WSearch", "DiagTrack")
foreach ($svc in $services) {
    Log "Disabling service: $svc"

    try {
        Stop-Service -Name $svc -Force -ErrorAction SilentlyContinue
        Set-Service -Name $svc -StartupType Disabled
        Log "$svc disabled successfully."
    } catch {
        Log ("Error disabling ${svc}: $_")
    }
}

# Disable background apps
Log "Disabling background apps..."

try {
    $regBA = "HKCU:\Software\Microsoft\Windows\CurrentVersion\BackgroundAccessApplications"
    if (-not (Test-Path $regBA)) {
        New-Item -Path $regBA -Force | Out-Null
    }
    Set-ItemProperty -Path $regBA -Name "GlobalUserDisabled" -Value 1 -Force
    Log "Background apps disabled."
} catch {
    Log "Error disabling background apps: $_"
}

# Disable animations and transparency
Log "Disabling animations and transparency effects..."

try {
    # Disable animations
    Set-ItemProperty -Path "HKCU:\Control Panel\Desktop\WindowMetrics" -Name "MinAnimate" -Value 0
    # Disable transparency
    $personalizePath = "HKCU:\Software\Microsoft\Windows\CurrentVersion\Themes\Personalize"
    if (-not (Test-Path $personalizePath)) {
        New-Item -Path $personalizePath -Force | Out-Null
    }
    Set-ItemProperty -Path $personalizePath -Name "EnableTransparency" -Value 0
    Log "Animations and transparency disabled."
} catch {
    Log "Error disabling animations/transparency: $_"
}

# Disable Windows Tips 
Log "Disabling Windows Tips..."

try {
    $path = "HKCU:\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager"
    if (-not (Test-Path $path)) { New-Item -Path $path -Force | Out-Null }
    Set-ItemProperty -Path $path -Name "SoftLandingEnabled" -Value 0 -Force
    Set-ItemProperty -Path $path -Name "SubscribedContent-310093Enabled" -Value 0 -Force
    Log "Windows Tips disabled."
} catch {
    Log "Error disabling Windows Tips: $_"
}

# Disable Hibernation
Log "Disabling hibernation to free disk space..."

try {
    powercfg -h off
    Log "Hibernation disabled successfully."
} catch {
    Log "Error disabling hibernation: $_"
}

# Optimize startup delay
Log "Optimizing startup delay..."

try {
    $serializePath = "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Serialize"
    if (-not (Test-Path $serializePath)) { New-Item -Path $serializePath -Force | Out-Null }
    Set-ItemProperty -Path $serializePath -Name "StartupDelayInMSec" -Value 0
    Log "Startup delay optimized."
} catch {
    Log "Error optimizing startup delay: $_"
}

Log "[Performance Module] Optimization complete."
