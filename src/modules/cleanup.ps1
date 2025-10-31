# cleanup.ps1
# SwiftEdge Security - Cleanup Module (CM1–CM7 with logging)

# ============== 
# Logging Setup 
# ==============
$logTime = Get-Date -Format "yyyyMMdd_HHmmss"
$moduleName = "CleanupModule"
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

Log "[${moduleName}] Starting Cleanup Module..."

# CM1: Clear temp files
Log "CM1: Clearing TEMP, %TEMP%, and PREFETCH folders..."
try {
    Remove-Item "$env:TEMP\*" -Recurse -Force -ErrorAction SilentlyContinue
    Remove-Item "C:\Windows\Temp\*" -Recurse -Force -ErrorAction SilentlyContinue
    Remove-Item "C:\Windows\Prefetch\*" -Recurse -Force -ErrorAction SilentlyContinue
    Log "CM1: Temporary files cleared successfully."
} catch {
    Log "CM1: Failed to clear temp files: $_"
}

# CM2: Clear Windows Update cache
Log "CM2: Clearing Windows Update cache..."
try {
    Stop-Service -Name wuauserv -Force -ErrorAction SilentlyContinue
    Stop-Service -Name bits -Force -ErrorAction SilentlyContinue
    Remove-Item "C:\Windows\SoftwareDistribution\Download\*" -Recurse -Force -ErrorAction SilentlyContinue
    Remove-Item "C:\Windows\SoftwareDistribution\DataStore\*" -Recurse -Force -ErrorAction SilentlyContinue
    Start-Service -Name wuauserv -ErrorAction SilentlyContinue
    Start-Service -Name bits -ErrorAction SilentlyContinue
    Log "CM2: Windows Update cache cleared successfully."
} catch {
    Log "CM2: Failed to clear update cache: $_"
}

# CM3: Empty Recycle Bin
Log "CM3: Emptying Recycle Bin..."
try {
    Clear-RecycleBin -Force -ErrorAction Stop
    Log "CM3: Recycle Bin emptied successfully."
} catch {
    Log "CM3: Failed to empty Recycle Bin: $_"
}

# CM4: Remove built-in apps (optional)
Log "CM4: Removing selected built-in apps..."
try {
    # Uncomment to include OneDrive
    # Get-AppxPackage *OneDrive* | Remove-AppxPackage 
    #Get-AppxPackage *Xbox* | Remove-AppxPackage 
    Get-AppxPackage *MicrosoftFeedback* | Remove-AppxPackage 
    Get-AppxPackage *Help* | Remove-AppxPackage 
    Log "CM4: Selected built-in apps removed."
} catch {
    Log "CM4: Failed to remove built-in apps: $_"
}

# CM5: Clear minor Event Logs
Log "CM5: Clearing minor Event Logs..."
try {
    $logs = wevtutil el
    foreach ($log in $logs) {
        try {
            wevtutil cl "$log"
            Log "CM5: Cleared event log: $log"
        } catch {
            Log "CM5: Skipped $log Access denied or locked."
        }
    }
    Log "CM5: Event log cleanup completed."
} catch {
    Log "CM5: Failed during event log loop: $_"
}

# CM6: Run Disk Cleanup
Log "CM6: Running Disk Cleanup..."
try {
    $cleanMgrKey = "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\VolumeCaches"
    Get-ChildItem $cleanMgrKey | ForEach-Object {
        New-ItemProperty -Path $_.PsPath -Name "StateFlags001" -Value 2 -PropertyType DWord -Force | Out-Null
    }
    cleanmgr /sagerun:1
    Log "CM6: Disk Cleanup executed successfully."
} catch {
    Log "CM6: Failed to run Disk Cleanup: $_"
}

# CM7: Extra cleanup
Log "CM7: Performing extra cleanup (logs, dumps)..."
try {
    Remove-Item "C:\Windows\Logs\*" -Recurse -Force -ErrorAction SilentlyContinue
    Remove-Item "C:\Windows\Minidump\*" -Recurse -Force -ErrorAction SilentlyContinue
    Remove-Item "C:\Windows\Memory.dmp" -Force -ErrorAction SilentlyContinue
    Log "CM7: Extra cleanup completed."
} catch {
    Log "CM7: Failed during extra cleanup: $_"
}

Log "[Cleanup Module] System Cleanup Completed."
