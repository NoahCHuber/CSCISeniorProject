# security2.ps1
# SwiftEdge Security - Security Hardening Module (Functions Only)
# NO automatic execution. Safe for GUI + PS2EXE.

# SM2 - Disable SMBv1
function Disable-SMBv1 {
	try {
		# Disable SMB1 Windows feature
		Disable-WindowsOptionalFeature -Online -FeatureName "SMB1Protocol" -NoRestart -ErrorAction Stop

		# Best-effort: also harden server config if cmdlet exists
		if (Get-Command Set-SmbServerConfiguration -ErrorAction SilentlyContinue) {
			Set-SmbServerConfiguration -EnableSMB1Protocol $false -Force -ErrorAction SilentlyContinue
		}

		return "SM2: SMBv1 disabled (feature + server configuration where available)."
	} catch {
		return "SM2 ERROR: Failed to disable SMBv1. $($_.Exception.Message)"
	}
}

# SM2 - Disable SMB Guest Access
function Disable-SMBGuestAccess {
	try {
		# Workstation side
		$wkPath = "HKLM:\SYSTEM\CurrentControlSet\Services\LanmanWorkstation\Parameters"
		if (-not (Test-Path $wkPath)) { New-Item -Path $wkPath -Force | Out-Null }
		New-ItemProperty -Path $wkPath -Name "AllowInsecureGuestAuth" -Value 0 -PropertyType DWord -Force | Out-Null

		# Server side (if available)
		if (Get-Command Set-SmbServerConfiguration -ErrorAction SilentlyContinue) {
			Set-SmbServerConfiguration -EnableInsecureGuestLogons $false -Force -ErrorAction SilentlyContinue
		}

		return "SM2: Insecure SMB guest access disabled."
	} catch {
		return "SM2 ERROR: Failed to harden SMB guest access. $($_.Exception.Message)"
	}
}

# SM3 - Disable Remote Assistance
function Disable-RemoteAssistance {
	try {
		$path = "HKLM:\SYSTEM\CurrentControlSet\Control\Remote Assistance"
		if (-not (Test-Path $path)) { New-Item -Path $path -Force | Out-Null }
		Set-ItemProperty -Path $path -Name "fAllowToGetHelp" -Value 0 -Force
		return "SM3: Remote Assistance disabled."
	} catch {
		return "SM3 ERROR: Failed to disable Remote Assistance. $($_.Exception.Message)"
	}
}


# SM3 - Disable Remote Registry
function Disable-RemoteRegistry {
	try {
		Stop-Service -Name RemoteRegistry -Force -ErrorAction SilentlyContinue
		Set-Service -Name RemoteRegistry -StartupType Disabled
		return "SM3: Remote Registry service disabled."
	} catch {
		return "SM3 ERROR: Failed to disable Remote Registry. $($_.Exception.Message)"
	}
}

# SM4 - Enable Defender Real-Time Protection
function Enable-DefenderRealtime {
	try {
		Set-MpPreference -DisableRealtimeMonitoring $false
		return "SM4: Defender real-time protection enabled."
	} catch {
		return "SM4 ERROR: Failed to enable Defender real-time protection. $($_.Exception.Message)"
	}
}

# SM4 - Enable Defender Behavior Monitoring
function Enable-DefenderBehavior {
	try {
		Set-MpPreference -DisableBehaviorMonitoring $false
		return "SM4: Defender behavior monitoring enabled."
	} catch {
		return "SM4 ERROR: Failed to enable Defender behavior monitoring. $($_.Exception.Message)"
	}
}

# SM4 - Enable Defender IOAV Protection
function Enable-DefenderIOAV {
	try {
		Set-MpPreference -DisableIOAVProtection $false
		return "SM4: Defender IOAV (download scanning) enabled."
	} catch {
		return "SM4 ERROR: Failed to enable Defender IOAV protection. $($_.Exception.Message)"
	}
}

# SM4 - Enable Memory Integrity (HVCI)
function Enable-MemoryIntegrity {
	try {
		$path = "HKLM:\SYSTEM\CurrentControlSet\Control\DeviceGuard\Scenarios\HypervisorEnforcedCodeIntegrity"
		if (-not (Test-Path $path)) { New-Item -Path $path -Force | Out-Null }
		New-ItemProperty -Path $path -Name "Enabled" -Value 1 -PropertyType DWord -Force | Out-Null
		return "SM4: Memory Integrity (HVCI) enabled. Reboot required."
	} catch {
		return "SM4 ERROR: Failed to enable Memory Integrity. $($_.Exception.Message)"
	}
}

# SM6 - Enable Windows Firewall (All Profiles)
function Enable-WindowsFirewallAllProfiles {
	try {
		if (Get-Command Set-NetFirewallProfile -ErrorAction SilentlyContinue) {
			Set-NetFirewallProfile -Profile Domain,Private,Public -Enabled True -ErrorAction Stop
			return "SM6: Windows Firewall enabled for Domain, Private, and Public profiles."
		} else {
			return "SM6 WARNING: NetFirewall cmdlets not available. Firewall not modified."
		}
	} catch {
		return "SM6 ERROR: Failed to enable Windows Firewall. $($_.Exception.Message)"
	}
}

# EXPORTED ARRAY: This is what main3.ps1 will loop through
$SecurityTweaks = @(
	@{ Text = "Disable SMBv1";                             Script = { Disable-SMBv1 } }
	@{ Text = "Disable SMB Guest Access";                  Script = { Disable-SMBGuestAccess } }
	@{ Text = "Disable Remote Assistance";                 Script = { Disable-RemoteAssistance } }
	@{ Text = "Disable Remote Registry";                   Script = { Disable-RemoteRegistry } }
	@{ Text = "Enable Defender Real-Time Protection";      Script = { Enable-DefenderRealtime } }
	@{ Text = "Enable Defender Behavior Monitoring";       Script = { Enable-DefenderBehavior } }
	@{ Text = "Enable Defender IOAV Protection";           Script = { Enable-DefenderIOAV } }
	@{ Text = "Enable Memory Integrity (HVCI)";            Script = { Enable-MemoryIntegrity } }
	@{ Text = "Enable Windows Firewall (All Profiles)";    Script = { Enable-WindowsFirewallAllProfiles } }
)
