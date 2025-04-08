# SwiftEdge Security  
**Software Requirements Document**  
**VERSION:** 1.0 (Pre-Release)  
**REVISION DATE:** April 8, 2025  

---

## Section 1: Purpose  
This document aims to define the software requirements for **SwiftEdge Security**, a performance and security utility for Windows systems. The application is developed using PowerShell and utilizes Windows Forms to deliver a sleek, modern, and minimal GUI. SwiftEdge Security is designed to improve performance, enhance system security, perform system cleanups, and provide vulnerability scanning by interfacing with open-source CVE APIs. It is built to be a one-stop solution for IT professionals, cybersecurity students, and system administrators who need a lightweight yet powerful tool without relying on external frameworks like Python or third-party runtimes.

---

## Section 2: General Requirements  

### 2.1 Major System Capabilities  
- GUI built entirely in PowerShell using Windows Forms (.NET).  
- Modular architecture with 3 primary tabs: Performance, Security, Cleanup, and Vulnerability/Software Scanning.  
- Executes individual PowerShell scripts per module, clearly separating functions.  
- Packs all functionality into a single `.exe` file using PS2EXE.  
- Functions entirely offline except for the vulnerability scanner.  
- Compatible with Windows 11 (64-bit).  
- GUI features a dark theme with neon purple accents for modern aesthetics.   

### 2.2 Major System Conditions  
- Must use PowerShell 5.1 or higher.  
- Must be run with administrative privileges.  
- Vulnerability scanning requires internet access for API calls.  
- Uses the Windows Registry, Services Manager, and file system for operations.  
- Utilized built-in modules must not overlap or interfere with one another.  
- No external dependencies beyond Windows-native tools, .NET libraries, and open-source CVE APIs.  

### 2.3 System Interfaces  
- Interfaces with Windows services.  
- Interacts with the Windows Registry to adjust performance/security/privacy settings.  
- Interfaces with:
  - **NVD API** for official CVE data.  
- Uses `Get-ItemProperty` to gather installed software data.  
- Uses `Invoke-RestMethod` to fetch CVE information dynamically.

### 2.4 System User Characteristics  
- Targeted toward:  
  - Cybersecurity students and professionals.  
  - IT administrators maintaining school or business systems.  
  - Power users on performance-limited machines.  
- Users access the app through a desktop environment.  
- Users are not expected to have deep technical skills.

---

## Section 3: Policy and Regulation Requirements  

### 3.1 Policy Requirements  
- Must adhere to organization-specific IT policies if deployed in institutions.  
- Must follow PowerShell script signing and execution policy guidelines.  
- Must not alter Group Policy settings unless explicitly enabled.
- Must not create any vulnerabilities after execution.

### 3.2 Regulation Requirements  
- No storage or handling of personally identifiable information (PII).  
- Compliant with FERPA and general educational data protection rules when used in schools.
- Can be industry-compliant to be used in the private sector and commercial applications.

---

## Section 4: Security Requirements  
- Script must prompt for elevation when system-level actions are needed.  
- Must block risky changes (e.g., disabling Defender) without user consent.  
- No telemetry or analytics are allowed.   
- Scripts modifying security settings must provide rollback capability. (I.E System Restore Point)

---

## Section 5: Training Requirements  
- Tooltips and info labels must explain each tweak/module.  
- A simple onboarding README or HTML help file must be included.  

---

## Section 6: Initial Capacity Requirements  
- Expected usage: occasional one-off scans or tweaks.  
- Peak memory usage should remain under 1GB.  
- Initial user base expected: Specific to active users only.  
- Performance scripts should be completed in under 30 seconds.

---

## Section 7: Initial System Architecture  
- Platform: Windows 11 (x64)  
- Language: PowerShell 5.1+  
- GUI Framework: .NET Windows Forms  
- Packaging Tool: PS2EXE  
- API Interfaces: NVD REST  
- Files:  
  - `SwiftEdgeSecurity.ps1` - Main GUI  
  - `Optimize-Performance.ps1`  
  - `Enhance-Security.ps1`  
  - `System-Cleanup.ps1`  
  - `Scan-Vulnerabilities.ps1`

---

## Section 8: System Acceptance Criteria  
- All buttons must execute their respective scripts without crashing.  
- Each module must output the success/failure of its operations.  
- The vulnerability scanner must display CVEs with software versions and a summary.  
- App must run smoothly on base-spec machines with a minimum spec requirement of 4GB of RAM and dual-core CPU. 

---

## Section 9: References  
- NVD API: https://nvd.nist.gov/developers  
- PS2EXE: https://github.com/MScholtes/PS2EXE  
- Chris Titus Tech Debloat Tool: Community inspiration  

---

## Section 10: Glossary  
- **CVE** – Common Vulnerabilities and Exposures  
- **GUI** – Graphical User Interface  
- **NVD** – National Vulnerability Database  
- **PS2EXE** – Tool to compile PowerShell into EXE  
- **SysMain** – Windows Service for performance prediction  

---

## Section 11: Document Revision History  
| Version | Date       | Name  | Description              |  
|---------|------------|-------|--------------------------|  
| 1.0     | 2025-04-08 | Swift | Initial requirements doc |

---

## Section 12: Appendices  
- GUI Mockups (to be included in final report)  
- Sample Log Files  
- API Key Configuration Template  
- Screenshot Examples of Each Module

---

© 2025 SwiftEdge Security  
All rights reserved.
