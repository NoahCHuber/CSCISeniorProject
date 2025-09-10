<# 
Cleanup Module Script
Implements CM1–CM7
NOTE: Run PowerShell as Administrator.
OneDrive removal is OPTIONAL. Uncheck before running if not desired.
#>

Write-Host "===== Starting Cleanup Module =====" -ForegroundColor Cyan

### CM1: Clear temporary files
Write-Host "Clearing TEMP, %TEMP%, and PREFETCH..." -ForegroundColor Yellow
Remove-Item -Path "$env:TEMP\*" -Recurse -Force -ErrorAction SilentlyContinue
Remove-Item -Path "C:\Windows\Temp\*" -Recurse -Force -ErrorAction SilentlyContinue
Remove-Item -Path "C:\Windows\Prefetch\*" -Recurse -Force -ErrorAction SilentlyContinue

### CM2: Clear Windows Update Cache
Write-Host "Stopping Windows Update services..." -ForegroundColor Yellow
Stop-Service -Name wuauserv -Force -ErrorAction SilentlyContinue
Stop-Service -Name bits -Force -ErrorAction SilentlyContinue

Write-Host "Deleting Windows Update cache..." -ForegroundColor Yellow
Remove-Item -Path "C:\Windows\SoftwareDistribution\Download\*" -Recurse -Force -ErrorAction SilentlyContinue
Remove-Item -Path "C:\Windows\SoftwareDistribution\DataStore\*" -Recurse -Force -ErrorAction SilentlyContinue

Write-Host "Restarting Windows Update services..." -ForegroundColor Yellow
Start-Service -Name wuauserv
Start-Service -Name bits

### CM3: Empty Recycle Bin
Write-Host "Emptying Recycle Bin..." -ForegroundColor Yellow
Clear-RecycleBin -Force -ErrorAction SilentlyContinue

### CM4: Remove built-in apps (OPTIONAL)
# Uncomment the apps you want to remove. (Do NOT remove OneDrive if unchecked!)
Write-Host "Removing selected built-in apps..." -ForegroundColor Yellow
# Get-AppxPackage *OneDrive* | Remove-AppxPackage
Get-AppxPackage *Xbox* | Remove-AppxPackage
Get-AppxPackage *MicrosoftFeedback* | Remove-AppxPackage
Get-AppxPackage *Help* | Remove-AppxPackage

### CM5: Clear minor Event Logs
Write-Host "Clearing Event Logs..." -ForegroundColor Yellow
wevtutil el | ForEach-Object { wevtutil cl $_ }

### CM6: Run Disk Cleanup (without Downloads)
Write-Host "Running Disk Cleanup..." -ForegroundColor Yellow
cleanmgr /sagerun:1

# Preconfigure Disk Cleanup options
$cleanMgrKey = "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\VolumeCaches"
Get-ChildItem $cleanMgrKey | ForEach-Object {
    New-ItemProperty -Path $_.PsPath -Name "StateFlags001" -Value 2 -PropertyType DWord -Force | Out-Null
}

### CM7: Extra cleanup (logs, temp leftovers, etc.)
Write-Host "Performing extra cleanup..." -ForegroundColor Yellow
# Delete leftover Windows logs
Remove-Item -Path "C:\Windows\Logs\*" -Recurse -Force -ErrorAction SilentlyContinue
# Delete system error dumps
Remove-Item -Path "C:\Windows\Minidump\*" -Recurse -Force -ErrorAction SilentlyContinue
Remove-Item -Path "C:\Windows\Memory.dmp" -Force -ErrorAction SilentlyContinue

Write-Host "===== Cleanup Completed Successfully =====" -ForegroundColor Green
