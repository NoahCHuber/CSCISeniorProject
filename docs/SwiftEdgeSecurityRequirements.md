# SwiftEdge Security  
**System Requirements Document**  
**VERSION:** 1.0  
**REVISION DATE:** April 8, 2025  

---

## Section 1: Purpose  
The purpose of this document is to define the system requirements for **SwiftEdge Security**, a performance and security utility for Windows systems. The application is developed using PowerShell and utilizes Windows Forms to deliver a sleek, modern GUI. SwiftEdge Security is designed to improve PC performance, enhance system security, perform thorough system cleanups, and provide vulnerability scanning by interfacing with open-source CVE APIs. It is built to be a one-stop solution for IT professionals, cybersecurity students, and system administrators who need a lightweight yet powerful tool without relying on external frameworks like Python or third-party runtimes.

---

## Section 2: General System Requirements  

### 2.1 Major System Capabilities  
- GUI built entirely in PowerShell using Windows Forms (.NET).  
- Modular architecture with 4 primary tabs: Performance, Security, Cleanup, Vulnerability Scanner.  
- Executes individual PowerShell scripts per module, providing a clear separation of functions.  
- Packs all functionality into a single `.exe` file using PS2EXE.  
- Functions entirely offline except for the vulnerability scanner.  
- Compatible with Windows 10 and Windows 11 (64-bit).  
- Designed for ease of use with minimal user training required.  
- GUI features a dark mode theme with neon purple accents for modern aesthetics.  
- Includes logging, notifications, and optional log exporting.  
- Written and maintained by an Applied Computing senior with a concentration in Cybersecurity.

### 2.2 Major System Conditions  
- Must use PowerShell 5.1 or higher.  
- Must be run with administrative privileges.  
- Vulnerability scanning requires internet access for API calls.  
- Uses the Windows Registry, Services Manager, and file system for operations.  
- GUI built-in modules must not overlap or interfere with one another.  
- No external dependencies beyond Windows-native tools and .NET libraries.  

### 2.3 System Interfaces  
- Interfaces with Windows services (e.g., SysMain, WSearch, DiagTrack).  
- Interacts with the Windows Registry to adjust performance/security/privacy settings.  
- Interfaces with:
  - **NVD API** for official CVE data.  
  - **Vulners API** for software-specific vulnerability queries.  
- Uses `Get-ItemProperty` to gather installed software data.  
- Uses `Invoke-RestMethod` to fetch CVE information dynamically.

### 2.4 System User Characteristics  
- Targeted toward:  
  - Cybersecurity students and professionals.  
  - IT administrators maintaining school or business systems.  
  - Power users on performance-limited machines.  
- Users access the app through a desktop environment.  
- The system must support 1–5 users per deployment.  
- Users are not expected to have deep technical skills.

---

## Section 3: Policy and Regulation Requirements  

### 3.1 Policy Requirements  
- Must adhere to organization-specific IT policies if deployed in institutions.  
- Must follow PowerShell script signing and execution policy guidelines.  
- Must not alter Group Policy settings unless explicitly enabled.  

### 3.2 Regulation Requirements  
- No storage or handling of personally identifiable information (PII).  
- Compliant with FERPA and general educational data protection rules when used in schools.  

---

## Section 4: Security Requirements  
- Script must prompt for elevation when system-level actions are needed.  
- Must block risky changes (e.g., disabling Defender) without user consent.  
- No telemetry or analytics are allowed.  
- Logging of sensitive data (e.g., installed apps) is optional and user-controlled.  
- Scripts modifying security settings must provide rollback capability.

---

## Section 5: Training Requirements  
- Tooltips and info labels must explain each tweak/module.  
- A simple onboarding README or HTML help file must be included.  
- GUI must not require more than 15 minutes of user onboarding.

---

## Section 6: Initial Capacity Requirements  
- Expected usage: occasional one-off scans or tweaks.  
- Peak memory usage should remain under 100MB.  
- Initial user base expected: < 10 users per environment.  
- Performance scripts should complete in under 5 seconds.

---

## Section 7: Initial System Architecture  
- Platform: Windows 10/11 (x64)  
- Language: PowerShell 5.1+  
- GUI Framework: .NET Windows Forms  
- Packaging Tool: PS2EXE  
- API Interfaces: NVD REST, Vulners REST  
- Files:  
  - `SwiftEdgeSecurity.ps1` - Main GUI  
  - `Optimize-Performance.ps1`  
  - `Enhance-Security.ps1`  
  - `System-Cleanup.ps1`  
  - `Scan-Vulnerabilities.ps1`

---

## Section 8: System Acceptance Criteria  
- All buttons must execute their respective scripts without crashing.  
- Each module must log success/failure of its operations.  
- Vulnerability scanner must display CVEs with scores and summaries.  
- App must run smoothly on base-spec machines (e.g., 4GB RAM, dual-core CPU).

---

## Section 9: Current System Analysis  
- No current solution is deployed.  
- SwiftEdge Security is a new greenfield project created to consolidate tools currently scattered across PowerShell community scripts and cybersecurity forums.

---

## Section 10: References  
- NVD API: https://nvd.nist.gov/developers  
- Vulners API: https://vulners.com/docs/  
- PS2EXE: https://github.com/MScholtes/PS2EXE  
- Chris Titus Tech Debloat Tool: Community inspiration  

---

## Section 11: Glossary  
- **CVE** – Common Vulnerabilities and Exposures  
- **GUI** – Graphical User Interface  
- **NVD** – National Vulnerability Database  
- **PS2EXE** – Tool to compile PowerShell into EXE  
- **SysMain** – Windows Service for performance prediction  

---

## Section 12: Document Revision History  
| Version | Date       | Name  | Description              |  
|---------|------------|-------|--------------------------|  
| 1.0     | 2025-04-08 | Noah  | Initial requirements doc |

---

## Section 13: Appendices  
- GUI Mockups (to be included in final report)  
- Sample Log Files  
- API Key Configuration Template  
- Screenshot Examples of Each Module

---

© 2025 SwiftEdge Security  
All rights reserved.