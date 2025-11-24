# cleanup2.ps1
# SwiftEdge Security - Cleanup Module (Functions Only)
# NO automatic execution. Safe for PS2EXE.

# Cleanup Module

# CM1 - Clear Temp Files
function Clear-TempFiles {
    try {
        Remove-Item "$env:TEMP\*" -Recurse -Force -ErrorAction SilentlyContinue
        Remove-Item "C:\Windows\Temp\*" -Recurse -Force -ErrorAction SilentlyContinue
        Remove-Item "C:\Windows\Prefetch\*" -Recurse -Force -ErrorAction SilentlyContinue
        return "CM1: Temporary files cleared."
    } catch {
        return "CM1 ERROR (Temp Files): $($_.Exception.Message)"
    }
}

# CM2 - Clear UpdateCache
function Clear-UpdateCache {
    try {
        Stop-Service wuauserv -Force -ErrorAction SilentlyContinue
        Stop-Service bits -Force -ErrorAction SilentlyContinue
        Remove-Item "C:\Windows\SoftwareDistribution\Download\*" -Recurse -Force -ErrorAction SilentlyContinue
        Remove-Item "C:\Windows\SoftwareDistribution\DataStore\*" -Recurse -Force -ErrorAction SilentlyContinue
        Start-Service wuauserv -ErrorAction SilentlyContinue
        Start-Service bits -ErrorAction SilentlyContinue
        return "CM2: Windows Update cache cleared."
    } catch {
        return "CM2 ERROR (Update Cache): $($_.Exception.Message)"
    }
}

# CM3 - Empty RecycleBin
function Empty-RecycleBin {
    try {
        Clear-RecycleBin -Force -ErrorAction Stop
        return "CM3: Recycle Bin emptied."
    } catch {
        return "CM3 ERROR (Recycle Bin): $($_.Exception.Message)"
    }
}

# CM4 - Remove Unnecessary Apps
function Remove-BloatApps {
    try {
        # Light and safe list
        Get-AppxPackage *MicrosoftFeedback* | Remove-AppxPackage -ErrorAction SilentlyContinue
        Get-AppxPackage *Help* | Remove-AppxPackage -ErrorAction SilentlyContinue
        return "CM4: Selected built-in apps removed."
    } catch {
        return "CM4 ERROR (App Removal): $($_.Exception.Message)"
    }
}

# CM5 - Clear EventLogs
function Clear-EventLogs {
    try {
        $logs = wevtutil el
        foreach ($log in $logs) {
            try {
                wevtutil cl "$log"
            } catch {
                # Skip protected logs silently
            }
        }
        return "CM5: Event logs cleared."
    } catch {
        return "CM5 ERROR (Event Logs): $($_.Exception.Message)"
    }
}

# CM6 Perform DiskCleanup
function DiskCleanup {
    try {
        $cleanMgrKey = "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\VolumeCaches"
        Get-ChildItem $cleanMgrKey | ForEach-Object {
            New-ItemProperty -Path $_.PsPath -Name "StateFlags001" -Value 2 -PropertyType DWord -Force | Out-Null
        }
        cleanmgr /sagerun:1
        return "CM6: Disk Cleanup executed."
    } catch {
        return "CM6 ERROR (Disk Cleanup): $($_.Exception.Message)"
    }
}

# CM7 Additional Cleanup
function Extra-Cleanup {
    try {
        Remove-Item "C:\Windows\Logs\*" -Recurse -Force -ErrorAction SilentlyContinue
        Remove-Item "C:\Windows\Minidump\*" -Recurse -Force -ErrorAction SilentlyContinue
        Remove-Item "C:\Windows\Memory.dmp" -Force -ErrorAction SilentlyContinue
        return "CM7: Extra cleanup completed."
    } catch {
        return "CM7 ERROR (Extra Cleanup): $($_.Exception.Message)"
    }
}

# EXPORTED ARRAY FOR MAIN UI (checkbox list)
$CleanTweaks = @(
    @{ Text = "Clear Temporary Files"; Script = { Clear-TempFiles } }
    @{ Text = "Clear Windows Update Cache"; Script = { Clear-UpdateCache } }
    @{ Text = "Empty Recycle Bin"; Script = { Empty-RecycleBin } }
    @{ Text = "Remove Small Built-in Apps"; Script = { Remove-BloatApps } }
    @{ Text = "Clear Event Logs"; Script = { Clear-EventLogs } }
    @{ Text = "Run Disk Cleanup"; Script = { DiskCleanup } }
    @{ Text = "Perform Additional Cleanup (Logs, Minidump, MemDump)";
    Script = { Extra-Cleanup } }
)