# SwiftEdge Security & Optimizer

## Project Description

SwiftEdge Security & Optimizer is a lightweight software application designed to enhance computer performance and security in a single, streamlined solution. The project aims to eliminate the need for multiple optimization and security tools by integrating system cleanup, performance tuning, and enhanced cybersecurity into one intuitive platform.

The application offers features such as junk file removal, system optimization, high-risk software version numbers, and real-time security checking. By leveraging automation and smart search algorithms, SwiftEdge enhances device speed, prevents slowdowns, and safeguards against cyber threats without requiring constant user intervention.

## Compile/Deploy

This application is developed using PowerShell scripts and can be compiled into a single executable using PS2EXE.
Run as Administrator for full module functionality.

### Current Build Workflow

**Build Steps:**
1. Open PowerShell in the project root. Typically, 'User/Documents/CSCISeniorProject/'

2. Run the build script: 'powershell -ExecutionPolicy Bypass -File .\scripts\build-single.ps1 -NoOutput'
> Note: The PowerShell ExecutionPolicy Bypass is not necessary if it is already disabled on your system.
> This build will have no additional debug output. If you want extra GUI confirmation, remove -NoOutput.

What the build script does:
- The build script checks that all required module files and mainFinal.ps1 exist, creates the dist folder if needed, then merges the module scripts into one combined script.
The build script then appends mainFinal.ps1 to the end of the combined script. > Just like procedural calls. 
- Saves the merged file as: 'dist\SwiftEdge-Compiled.ps1'
- The build script then called the compiler PS2EXE to compile the single PowerShell script into an executable:  'dist\SwiftEdge-Compiled.exe'

3. If you only want the combined PowerShell script and not the EXE:
  'powershell -ExecutionPolicy Bypass -File .\scripts\build-single.ps1 -SkipExe'

## Usage

SwiftEdge currently includes four GUI tabs:

- Performance
- Cleanup
- Security
- Vulnerability

## Suggested Options 

> Note: A system restore point should be created before any modules are run. 

**Performance Module:**
> Current options focused on speed and responsiveness:

- Set Ultimate Performance power plan (fallback to High Performance if needed)
- Disable SysMain (Superfetch) service
- Disable Windows Search (WSearch)
- Disable DiagTrack
- Disable window animations
- Disable transparency
- Disable background apps via registry
- Disable Windows tips
- Disable hibernation
- Optimize startup delay
- Disable startup applications (current user `Run` entries, with backup for restore)
- Enable Game Mode
- Enable Hardware-Accelerated GPU Scheduling (reboot may be required)
- Reset Performance to Defaults button (module-level reset path)

**Security Hardening Module:**
> Current options for hardening and safe baseline configuration:

- Disable SMBv1 protocol
- Disable SMB Guest Access
- Disable Remote Assistance
- Disable Remote Registry
- Enable Defender Real-Time protection
- Enable Defender Behavior monitoring
- Enable Defender IOAV protection
- Enable Memory Integrity (HVCI)
- Enable Windows Firewall for all profiles
- Reset Security to Defaults button (safe baseline reset, not factory Windows defaults)

**System Cleanup Module:**
> Current options for removing junk and temporary data:

- Clean %TEMP% and C:\Windows\Temp
- Clear prefetch/superfetch cache
- Clear Windows Update cache
- Clear Event Viewer logs
- Remove selected built-in apps (`MicrosoftFeedback`, `Help`)
- Run Disk Cleanup
- Empty Recycle Bin
- Perform additional cleanup (logs/minidumps/memory dump file)

**Vulnerability & Software Scanning Module:**
> Current scanner behavior:

- Scan and list installed programs with versions
- Download/use local cache of NVD yearly JSON feed
- Match installed app names/versions against NVD CPE version ranges
- Display top vulnerable apps and CVE IDs with CVSS severity/score in the GUI text panel

Not currently implemented in code:

- Vulners API integration
- Export to TXT/CSV from vulnerability tab
- Automatic latest-version check for installed software

## Testing
> This section outlines the key validation and testing criteria for SwiftEdge Security. Each feature module must function independently and correctly, without requiring external runtimes or manual configuration. The following checklist ensures that all performance, security, cleanup, and vulnerability scan operations perform as expected in the final executable version.

**General Application Behavior:**
| *Test Case*	                                   | *Expected Result*                                         |
| ---------------------------------------------- | --------------------------------------------------------- |
| Application launches without errors	           | Main GUI loads with all tabs and buttons functional       |
| GUI layout renders properly              	     | All text is visible and no elements are clipped           |
| Runs without requiring external dependencies	 | No errors related to ps1, .NET Core, or external database |
| Elevated permissions are requested when needed | UAC prompt appears for operations requiring admin rights  |
| Log files are generated when enabled	         | Logs record operation timestamps and success/failure      |   

**Performance Module Checklist:**
| *Test Case*	                                  | *Expected Result*                                   |
| --------------------------------------------- | --------------------------------------------------- |
| A high-performance power plan is applied	    | Power plan changes are confirmed via powercfg       |
| SysMain and WSearch services are disabled	    | Services are stopped and set to Disabled            |
| Background apps disabled in registry	        | Registry key reflects the correct setting           |
| Visual effects are turned off	                | Animations and transparency are disabled            |
| Startup delay removed	                        | Registry key StartupDelayInMSec is set to 0         |
| Startup apps are disabled                      | Current-user Run entries are removed and backed up  |
| Game mode and HAGS can be enabled              | Registry values are set and change applies after reboot if required |

**Security Hardening Checklist:**
| *Test Case*	                                  | *Expected Result*                                                 | 
| --------------------------------------------- | ----------------------------------------------------------------- |
| SMBv1 is disabled	                            | Feature is not listed in Windows Features                         | 
| Remote assistance and registry are disabled	  | Services are stopped and the registry reflects the disabled state | 
| Windows Defender settings are updated	        | Real-time, behavior monitoring, and IOAV are enabled             | 
| A system restore point is created	            | Restore point is visible in the System Restore panel              | 
| Firewall is enabled for all profiles	          | Domain, Private, and Public profiles are enabled                  | 

**Cleanup Module Checklist:**
| *Test Case*	                              | *Expected Result*                                       | 
| ----------------------------------------- | ------------------------------------------------------- |
| Temporary folders are emptied	            | %TEMP% and C:\Windows\Temp show a reduced file count    | 
| Event Viewer logs are cleared	            | Application/System/Security logs show no recent entries | 
| Windows Update cache is cleared	          | SoftwareDistribution\Download folder is empty           | 
| Selected built-in apps removed	         | App list no longer includes matching Feedback/Help entries |
| RecycleBin is emptied	                    | Bin is confirmed to be empty                            |    

**Vulnerability Scanning Checklist:**
| *Test Case*	                               | *Expected Result*                                  | 
| ------------------------------------------ | -------------------------------------------------- |
| The installed software list is retrieved	 | The List shows app names and version numbers       | 
| NVD API is queried successfully	           | CVEs with IDs, summaries, and CVSS scores appear   | 
| No connection = graceful failure	         | App shows a message without crashing               |     

**Pass/Fail Criteria:**   \
*Pass:* All core modules are complete with no errors, and scan results are displayed correctly in the UI.

*Fail:* Application crashes do not apply expected system changes or do not retrieve vulnerability data when online.
