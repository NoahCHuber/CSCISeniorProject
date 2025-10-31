# security.ps1
# SwiftEdge Security - Security Hardening Module (SM1–SM5 with logging)

# ============== 
# Logging Setup 
# ==============
$logTime = Get-Date -Format "yyyyMMdd_HHmmss"
$moduleName = "SecurityModule"
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

Log "[${moduleName}] Starting Security Hardening Module..."

# SM5: Confirm with user before applying hardening
$confirmation = Read-Host "SM5: Do you want to apply system security hardening? (Y/N)"
if ($confirmation -ne "Y" -and $confirmation -ne "y") {
    Log "SM5: User declined to apply security hardening."
    exit
}

# SM2: Disable SMBv1 via Windows Features
Log "SM2: Disabling SMBv1..."
try {
    Disable-WindowsOptionalFeature -Online -FeatureName "SMB1Protocol" -NoRestart -ErrorAction Stop
    Log "SM2: SMBv1 disabled."
} catch {
    Log "SM2: SMBv1 may already be disabled or failed to disable: $_"
}

# SM3: Disable Remote Assistance and Remote Registry
Log "SM3: Disabling Remote Assistance and Remote Registry..."
try {
    Set-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Control\Remote Assistance" -Name "fAllowToGetHelp" -Value 0
    Log "SM3: Remote Assistance disabled via registry."
} catch {
    Log "SM3: Failed to disable Remote Assistance: $_"
}

try {
    Stop-Service -Name RemoteRegistry -Force -ErrorAction SilentlyContinue
    Set-Service -Name RemoteRegistry -StartupType Disabled
    Log "SM3: Remote Registry service disabled."
} catch {
    Log "SM3: Failed to disable Remote Registry: $_"
}

# SM4: Enable Defender Settings & Memory Integrity
Log "SM4: Enabling Windows Defender and Memory Integrity..."

try {
    Set-MpPreference -DisableRealtimeMonitoring $false
    Set-MpPreference -DisableBehaviorMonitoring $false
    Set-MpPreference -DisableIOAVProtection $false
    # Set-MpPreference -EnableControlledFolderAccess Enabled
    Log "SM4: Windows Defender settings enabled."
} catch {
    Log "SM4: Failed to enable Defender settings: $_"
}

try {
    $memIntegrityReg = "HKLM:\SYSTEM\CurrentControlSet\Control\DeviceGuard\Scenarios\HypervisorEnforcedCodeIntegrity"
    if (-not (Test-Path $memIntegrityReg)) {
        New-Item -Path $memIntegrityReg -Force | Out-Null
    }
    Set-ItemProperty -Path $memIntegrityReg -Name "Enabled" -Value 1
    Log "SM4: Memory Integrity enabled (requires reboot)."
} catch {
    Log "SM4: Failed to enable Memory Integrity: $_"
}

Log "[${moduleName}] Security Hardening Complete."
