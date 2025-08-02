# optimize-performance.ps1
# SwiftEdge Security - Performance Optimization Module (with logging)

# ==============
# Logging Setup
# ==============
$logTime = Get-Date -Format "yyyyMMdd_HHmmss"
$moduleName = "OptimizePerformance"
$logPath = "..\..\logs\SwiftEdgeLog_${logTime}_${moduleName}.log"

# Create logs folder if it does not exist
$logFolder = "..\..\logs"
if (-not (Test-Path $logFolder)) {
    New-Item -ItemType Directory -Path $logFolder -Force | Out-Null
}

# Function to log and display
function Log {
    param ([string]$Message)
    $Message | Tee-Object -FilePath $logPath -Append
}

Log "[${moduleName}] Starting Performance Optimization Module..."

Log "[Performance Module] Starting optimization..."

# Enable Ultimate Performance / Fallback to High Performance
Log "Enabling Ultimate Performance power plan..."

try {
    $ultimateGUID = "e9a42b02-d5df-448d-aa00-03f14749eb61"
    $ultimateExists = powercfg -list | Select-String $ultimateGUID

    if (-not $ultimateExists) {
        Log "Ultimate Performance plan not found. Attempting to add it..."
        powercfg -duplicatescheme $ultimateGUID | Out-Null
    }

    powercfg -setactive $ultimateGUID
    Log "Ultimate Performance plan is now active."
}
catch {
    Log "Unable to enable Ultimate Performance plan. Attempting to enable High Performance instead..."
    try {
        $highPerfGUID = (powercfg -list | Select-String "High performance").ToString().Split()[3]
        powercfg -setactive $highPerfGUID
        Log "High Performance plan enabled."
    } catch {
        Log "Error setting any power plan: $($_.Exception.Message)"
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
