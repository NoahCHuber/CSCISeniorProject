# performance.ps1
# SwiftEdge Security - Performance Optimization Module (PM1–PM7 with logging)

# ============== 
# Logging Setup 
# ==============
$logTime = Get-Date -Format "yyyyMMdd_HHmmss"
$moduleName = "Performance"
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

Log "[${moduleName}] Starting Performance Optimization Module..."

Log "[Performance Module] Starting Optimization..."

# PM1: Change Power Plan to High/Ultimate Performance
Log "PM1: Setting Ultimate Performance power plan..."
Log "Note: You may see 'Attempted to write to unsupported setting' this is normal and does not affect functionality."

powercfg -duplicatescheme e9a42b02-d5df-448d-aa00-03f14749eb61 | Out-Null

try {
    powercfg -setactive e9a42b02-d5df-448d-aa00-03f14749eb61
    Log "PM1: Ultimate Performance plan is now active."
} catch {
    Log "PM1: Failed to activate Ultimate Performance plan. Trying High Performance instead..."
    try {
        $highPerfGUID = (powercfg -list | Select-String "High performance").ToString().Split()[3]
        powercfg -setactive $highPerfGUID
        Log "PM1: High Performance plan enabled."
    } catch {
        Log "PM1: Unable to activate any performance plan: $($_.Exception.Message)"
    }
}

# PM2: Disable SysMain, WSearch, DiagTrack Services
Log "PM2: Disabling non-essential services..."
$services = @("SysMain", "WSearch", "DiagTrack")

foreach ($svc in $services) {
    Log "PM2: Disabling service: $svc"
    try {
        Stop-Service -Name $svc -Force -ErrorAction SilentlyContinue
        Set-Service -Name $svc -StartupType Disabled
        Log "PM2: $svc disabled successfully."
    } catch {
        Log ("PM2: Error disabling ${svc}: $_")
    }
}

# PM3: Disable Windows animations and transparency
Log "PM3: Disabling animations and transparency..."
try {
    Set-ItemProperty -Path "HKCU:\Control Panel\Desktop\WindowMetrics" -Name "MinAnimate" -Value 0
    $personalizePath = "HKCU:\Software\Microsoft\Windows\CurrentVersion\Themes\Personalize"
    if (-not (Test-Path $personalizePath)) {
        New-Item -Path $personalizePath -Force | Out-Null
    }
    Set-ItemProperty -Path $personalizePath -Name "EnableTransparency" -Value 0
    Log "PM3: Animations and transparency disabled."
} catch {
    Log "PM3: Error disabling visual effects: $_"
}

# PM4: Disable all background apps
Log "PM4: Disabling background apps..."
try {
    $regBA = "HKCU:\Software\Microsoft\Windows\CurrentVersion\BackgroundAccessApplications"
    if (-not (Test-Path $regBA)) {
        New-Item -Path $regBA -Force | Out-Null
    }
    Set-ItemProperty -Path $regBA -Name "GlobalUserDisabled" -Value 1 -Force
    Log "PM4: Background apps disabled."
} catch {
    Log "PM4: Error disabling background apps: $_"
}

# PM5: Disable Windows Tips
Log "PM5: Disabling Windows Tips ..."
try {
    $tipsPath = "HKCU:\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager"
    if (-not (Test-Path $tipsPath)) {
        New-Item -Path $tipsPath -Force | Out-Null
    }
    Set-ItemProperty -Path $tipsPath -Name "SoftLandingEnabled" -Value 0 -Force
    Set-ItemProperty -Path $tipsPath -Name "SubscribedContent-310093Enabled" -Value 0 -Force
    Log "PM5: Windows Tips disabled."
} catch {
    Log "PM5: Error disabling Windows Tips: $_"
}

# Disable Hibernation
Log "PM5: Disabling hibernation to free disk space..."
try {
    powercfg -h off
    Log "PM5: Hibernation disabled successfully."
} catch {
    Log "PM5: Error disabling hibernation: $_"
}

# PM6: Remove startup delay via Registry
Log "PM6: Optimizing startup delay..."
try {
    $serializePath = "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Serialize"
    if (-not (Test-Path $serializePath)) {
        New-Item -Path $serializePath -Force | Out-Null
    }
    Set-ItemProperty -Path $serializePath -Name "StartupDelayInMSec" -Value 0
    Log "PM6: Startup delay optimized."
} catch {
    Log "PM6: Error optimizing startup delay: $_"
}

# PM7: Run Disk Optimization
Log "PM7: Running disk optimization..."
try {
    Optimize-Volume -DriveLetter C -Verbose
    Log "PM7: Disk optimization executed."
} catch {
    Log "PM7: Error running disk optimization: $_"
}

Log "[Performance Module] Optimization Complete."