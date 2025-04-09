# SwiftEdge Security & Optimizer

## Brief Project Description

SwiftEdge Security & Optimizer is a lightweight software application designed to enhance computer performance and security in a single, streamlined solution. The project aims to eliminate the need for multiple optimization and security tools by integrating system cleanup, performance tuning, and enhanced cybersecurity into one intuitive platform.

The application offers features such as junk file removal, system optimization, high-risk software version numbers, and real-time security checking. By leveraging automation and smart search algorithms, SwiftEdge enhances device speed, prevents slowdowns, and safeguards against cyber threats without requiring constant user intervention.

## Compile/Deploy

This application is developed using PowerShell scripts and will be compiled into a single executable using PS2EXE. 
This application must be run using administrator privileges when opening the .exe. A Windows Form should open and the user can select the options they would like before running the script for each section. The GUI is modular and each section will have its own interface and button to execute the script. To learn more details please see the user interface section in the requirements document. 

## Usage

System Clean Up (Unused System Files) \
Performance Optimizations (Changes Registry for performance booster) \ 
Security Check and Hardening (Checks for Generic Vulnerabilities and Optional System Hardening) \
Software Version Checker (Checks Software Version Numbers for Vulnerabilities using external NVD CVE)   

## Suggested Options 

**Performance Module:**
> Options focused on improving speed, responsiveness, and reducing system overhead:

- Set Power Plan to “High Performance” or “Ultimate Performance”
- Disable SysMain (Superfetch) service
- Disable Search Indexing (WSearch)
- Disable Xbox-related services (XblAuthManager, XblGameSave, etc.)
- Disable background apps via registry
- Remove startup delay via registry
- Turn off Windows animations and visual effects
- Clear prefetch/superfetch cache
- Disable telemetry-related scheduled tasks
- Adjust visual settings for best performance
- Restart Windows Explorer (quick refresh option)

**Security Hardening Module:**
> Options for improving system security and reducing the attack surface:

- Disable SMBv1 protocol
- Disable Remote Assistance
- Disable Remote Registry
- Enable Windows Defender cloud protection
- Enable Windows Defender tamper protection
- Disable Windows Script Host
- Configure basic outbound firewall rules
- Disable data collection and telemetry features
- Disable Wi-Fi Sense
- Create a System Restore Point before changes

**System Cleanup Module:**
> Options for removing junk, temp files, and unnecessary applications:

- Clean %TEMP% and C:\Windows\Temp
- Clear Windows Update cache
- Remove old system restore points (optional)
- Clear Event Viewer logs
- Uninstall OneDrive
- Optionally Remove Xbox Game Bar and Feedback Hub
- Disable hibernation (optional)
- Run Disk Cleanup silently
- Empty Recycle Bin

**Vulnerability & Software Scanning Module:**
> Options for inspecting installed applications and identifying known risks:

- Scan and list installed programs with versions
- Query NVD API for known vulnerabilities
- Query Vulners API for advanced CVE info (optional)
- Display CVE ID, severity score (CVSS), and summary
- Export vulnerability results to TXT or CSV
- Flag outdated or unsupported software

**Optional:** Check for latest versions of detected software

## Testing

TO BE COMPLETED LATER

