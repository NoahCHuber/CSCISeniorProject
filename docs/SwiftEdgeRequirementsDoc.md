# Software Requirements Document

## SwiftEdge Security & Optimizer
Version: 1.0 (Pre-release)  
Prepared by: Noah Huber and Daniel Howard  
Organization: SwiftEdge Security   
Date Created: April 8th, 2025  

Table of Contents
=================
* [Revision History](#revision-history)
* 1 [Introduction](#1-introduction)
  * 1.1 [Document Purpose](#11-document-purpose)
  * 1.2 [Product Scope](#12-product-scope)
  * 1.3 [Definitions, Acronyms, and Abbreviations](#13-definitions-acronyms-and-abbreviations)
  * 1.4 [References](#14-references)
  * 1.5 [Document Overview](#15-document-overview)
* 2 [Product Overview](#2-product-overview)
  * 2.1 [Product Perspective](#21-product-perspective)
  * 2.2 [Product Functions](#22-product-functions)
  * 2.3 [Product Constraints](#23-product-constraints)
  * 2.4 [User Characteristics](#24-user-characteristics)
  * 2.5 [Assumptions and Dependencies](#25-assumptions-and-dependencies)
* 3 [Requirements](#3-requirements)
  * 3.1 [External Interfaces](#31-external-interfaces)
    * 3.1.1 [User Interfaces](#311-user-interfaces)
    * 3.1.2 [Hardware Interfaces](#312-hardware-interfaces)
    * 3.1.3 [Software Interfaces](#313-software-interfaces)
  * 3.2 [Functional Requirements](#32-functional-requirements)
    * 3.2.1 [General Functional Requirements](#321-general-functional-requirements)
    * 3.2.2 [Performance Module](#322-performance-module)
    * 3.2.3 [Security Module](#323-security-module)
    * 3.2.4 [Cleanup Module](#324-cleanup-module)
    * 3.2.5 [Vulnerability Scanner Module](#325-vulnerability-scanner-module)
  * 3.3 [Quality of Service](#33-quality-of-service)
    * 3.3.1 [Performance](#331-performance)
    * 3.3.2 [Security](#332-security)
    * 3.3.3 [Reliability](#333-reliability)
    * 3.3.4 [Availability](#334-availability)
  * 3.4 [Compliance](#34-compliance)
  * 3.5 [Design and Implementation](#35-design-and-implementation)
    * 3.5.1 [Installation](#351-installation)
    * 3.5.2 [Distribution](#352-distribution)
    * 3.5.3 [Maintainability](#353-maintainability)
    * 3.5.4 [Reusability](#354-reusability)
    * 3.5.5 [Portability](#355-portability)
    * 3.5.6 [Cost](#356-cost)
    * 3.5.7 [Deadline](#357-deadline)
    * 3.5.8 [Proof of Concept](#358-proof-of-concept)
* 4 [Verification](#4-verification)
  * 4.1 [Product Testing and Verification](#41-product-testing-and-verification)
* 5 [References](#5-references)
  * 5.1 [Documentation](#51-documentation)
  * 5.2 [Github Repositories](#52-github-repositories)
  * 5.3 [BAD EXAMPLES OF SOFTWARE](#53-bad-examples-of-software)

## Revision History
|  Name(s)  |    Date    |    Reason For Changes   |   Version   |
| --------- | ---------- | ----------------------- | ----------- |
| SwiftEdge | 2025-08-04 | Intiial Requirments Doc |     1.0     |
|    Noah   | 2025-09-04 | Drafting and Additions  |     1.0     |
|   Daniel  | 2025-10-04 | Editing and Review      |     1.1     |
|   Daniel  | 2025-15-04 | Adding to Section 3     |     1.11    |
|    Noah   | 2025-15-04 | Final Draft Revisions   |     1.11    |

## 1. Introduction
> This document defines the system requirements for SwiftEdge Security, a modular, GUI-based Windows utility designed to improve system performance, enhance security, perform cleanup operations, and check for known vulnerabilities. Developed entirely in PowerShell with a Windows Forms front end, this tool provides users with a streamlined interface and powerful functionality—all packaged as a standalone executable.

This Software Requirements Document (SRD) aims to outline the functional and non-functional requirements of SwiftEdge Security, including performance targets, security expectations, user interaction, system interfaces, and constraints. It serves as a single reference point for developers, testers, and academic advisors to ensure a consistent understanding of the system’s scope, behavior, and expected outcomes. This document is intended for software developers, academic advisors, and IT professionals interested in the application's design, implementation, and implications. This document also includes references for external APIs, packaging tools, and third-party components used during development. 

### 1.1 Document Purpose
This document aims to define the software requirements for SwiftEdge Security & Optimizer, a performance and security utility for Windows systems. The application is developed using PowerShell and utilizes Windows Forms to deliver a sleek, modern, and minimal GUI. SwiftEdge Security is designed to improve performance, enhance system security, perform system cleanups, and provide vulnerability scanning by interfacing with open-source Common Vulnerabilities and Exposures(CVE) APIs. It is built to be a one-stop solution for IT professionals, cybersecurity students, and system administrators who need a lightweight yet powerful tool without external frameworks.

### 1.2 Product Scope
SwiftEdge Security is a modular utility for Windows designed to streamline system maintenance and protection through four key functions: performance tuning, security hardening, system cleanup, and vulnerability scanning. Each module operates independently, offering users a focused experience through a unified PowerShell-based GUI. 
This software operates as a self-contained executable that performs real-time system configuration tasks using native Windows features and external vulnerability databases. Its intended use is for enhancing local machine performance and reducing exposure to known vulnerabilities without requiring deep system knowledge or large, third-party frameworks.

Key deliverables for this version (v1.0) include:
- Provide a lightweight, portable, and efficient tool for optimizing and securing Windows systems.
- Replace the need for multiple standalone scripts or tools by consolidating core administrative tasks into a unified interface.
- Offer open-source vulnerability checking through integration with APIs like the National Vulnerability Database (NVD) and Vulners.
- Deliver a clean and professional GUI experience without requiring .NET installation or third-party frameworks, ensuring minimal dependencies and maximum accessibility.
- Compatibility with Windows 11.
- A Windows Forms-based GUI with tab navigation.

SwiftEdge Security aligns with broader educational and practical goals by offering a real-world cybersecurity solution that demonstrates scripting, GUI design, API integration, and system administration techniques, all while addressing key points in day-to-day Windows system management.

### 1.3 Definitions, Acronyms and Abbreviations
> Below are definitions, acronyms, or abbreviations used throughout the SRD.

**GUI:** Graphical User Interface  
**SRD:** Software Requirements Document  
**IT:** Information Technology  
**API:** Application Programming Interface  
**CVE:** Common Vulnerabilities and Exposures  
**NVD:** National Vulnerability Database  
**AV:** Anti-Virus  
**Powershell:** 	A command-line shell and scripting language designed for system admin tasks in Windows.  
**PS2EXE:** 	A third-party PowerShell module used to compile .ps1 scripts into standalone Windows executable (.exe) files.  
**Windows Forms:** A GUI framework in the .NET platform used for building desktop interfaces, accessible through PowerShell.  
**Module:** A specific functional unit within SwiftEdge Security (e.g., Performance, Security, Cleanup, or Vulnerability Scan).  
**Standalone Executable:** A self-contained application that does not require the installation of external frameworks to run.  

### 1.4 References
> This Software Requirements Document (SRD) does not rely on any previously established vision or scope document. All project-related references, including external tools, APIs, and third-party components, are included in Section 5 – References.

### 1.5 Document Overview
>This document is structured to comprehensively define the requirements for the SwiftEdge Security software. It is organized to follow industry-standard software engineering practices to ensure clarity, traceability, and completeness throughout the software development lifecycle.

*Below are the sections of this document with a brief overview of what each section contains.*

**Section 2 – Product Overview:** 
*Provides general background information, including the system's origin, its major functionalities, external constraints, user characteristics, assumptions, and how requirements are distributed across the software's components.*

**Section 3 – Requirements:** 
*Details both the functional and non-functional requirements of the system. This includes software features, quality attributes (such as performance, reliability, and security), and compliance with standards or regulations. External interfaces and design constraints are also described here.*

**Section 4 – Verification:** 
*Outlines how the software will be tested and validated against the requirements specified in Section 3. It includes the planned verification methods and criteria for determining successful implementation.
(Due to the size of this project, actual verification of the software will not be filed.)*

**Section 5 – Appendices:** 
*Contains any supplemental material, such as references, diagrams, mockups, glossaries, and additional documentation that support or extend the main content of the SRD.*

## 2. Product Overview
> This section should describe the general factors that affect the product and its requirements. This section does not state specific requirements. Instead, it provides a background for those requirements, which are defined in detail in Section 3, and makes them easier to understand.

### 2.1 Product Perspective
SwiftEdge Security is a new, self-contained system developed as a standalone utility for Windows 11 environments. It is not part of an existing software family and does not serve as a direct replacement for any commercial or enterprise-level product. However, it draws conceptual inspiration from tools like Chris Titus Tech’s Windows Utility, Talon by RavenDevTeam, and Azurite Optimizer while providing a cleaner, more security-driven PowerShell-native alternative.

This product is designed to consolidate multiple commonly used administrative and security actions, such as disabling bloatware, optimizing performance settings, and checking for known software vulnerabilities inside a unified user interface. By building the software entirely in PowerShell and packaging it with PS2EXE, SwiftEdge Security eliminates the need for Python runtimes, Python wrapping with Nuitka, third-party debloaters, and manual PowerShell script execution.

**There are no direct dependencies on other systems. However, it does interface with:**
- The Windows Registry (for performance and privacy tweaks),
- The Windows Service Controller (to manage and disable services),
- The NVD API (to retrieve vulnerability data based on installed software),
- Local system components like Power Plans, Disk Cleanup, Defragmentation, and Temp File Directories.

### 2.2 Product Functions
> SwiftEdge Security provides a modular interface that enables users to perform common system maintenance, optimization, and security tasks on Windows 11 systems. Each function is encapsulated within its own script and is accessible via a centralized GUI.

**At a high level, the product must allow users to:**   

*Performance Optimization*
- Enable the High Performance or Ultimate Performance power plan. 
- Disable non-essential services such as SysMain and Windows Search.
- Disable background apps, animations, and transparency effects.
- Optimize registry settings for boot and responsiveness improvements.

*Security Hardening*
- Disable vulnerable or unnecessary services (e.g., SMBv1, Remote Assistance).
- Enable key Windows Defender features like tamper protection and memory integrity.
- Apply firewall or system-level security tweaks to reduce attack surface.
- Offer the option to create a System Restore Point before applying changes.

*System Cleanup*
- Clear system temp folders and Windows Update caches.
- Remove unused or unwanted built-in Windows applications.
- Clear Event Viewer logs and optionally disable hibernation.
- Free up storage by automating disk cleanup and emptying the recycle bin.

*Vulnerability Scanning*
- Detect installed applications and retrieve their version numbers.
- Query open-source CVE databases (e.g., NVD API) to identify known vulnerabilities.
- Display CVE results with severity scores and summaries.
- Allow export of scan results to CSV or TXT.

*User Interface and Workflow*
- Provide a tab-based GUI built in PowerShell using Windows Forms.
- Require administrative privileges for critical operations.
- Display status and result feedback within the GUI.
- Function as a standalone EXE file requiring no third-party framework installation.

### 2.3 Product Constraints
> The following constraints define limitations that impact the design, development, or implementation of SwiftEdge Security:

**Interface Constraints:**
- The graphical user interface (GUI) must be implemented using Windows Forms within PowerShell, limiting the available design flexibility compared to full GUIs like Tkinter, .NET, or other web-based frameworks.
- All modules must be accessible through a tabbed layout, restricting deeper nested features or advanced navigation models.
The application will run only on Windows 11 (64-bit) systems and does not support macOS or Linux environments.

**Quality of Service Constraints:**
- All actions must complete with minimal delay (under 30 seconds), particularly on low-end systems with 4GB RAM and dual-core processors.
- Vulnerability scanning requires internet access and may be limited by API rate limits or response time from external databases.

**Standards and Compliance Constraints:**
- PowerShell scripts must comply with Windows Execution Policy and may require elevated privileges (Administrator access) to perform system-level changes.
- When deployed in educational or institutional settings, the tool must not violate FERPA, PII handling guidelines, or local IT usage policies.

**Design and Implementation Constraints:**
- The application must be built using only PowerShell 5.1+ without relying on third-party frameworks such as Python, Node.js, or compiled .NET projects.
- Final distribution must be in the form of a standalone executable created with PS2EXE, requiring all features to be embedded within a single compiled script.
- Modules must remain functionally independent, avoiding shared state or dependencies across performance, security, cleanup, or scanning functions.

### 2.4 User Characteristics
> SwiftEdge Security is designed with usability in mind, targeting a range of user classes with varying levels of technical expertise. The software’s simple, tab-based interface and modular structure allow it to serve both professional and non-professional users, with most functionality accessible in a few clicks. User groups are distinguished based on how frequently they use the tool, their level of system access, and their understanding of Windows system administration.

**Primary User Classes:**   
**1. IT Professionals / System Administrators**   
**Role:** *Maintain Windows systems in school districts, small businesses, or tech support environments.*   
**Technical Skill Level:**  *Intermediate to advanced.*   
**Frequency of Use:** *Moderate to frequent.*   
**Privileges:** *Full administrative access.*   
**Modules Used:** *All (Performance, Security, Cleanup, Vulnerability Scan).*   
**Priority Level:** *High — This group is the most critical to satisfy, as they will benefit the most from the tool’s full range of features.*   

**2. Cybersecurity Students / Technical Interns**   
**Role:** *Use SwiftEdge Security for learning, testing, or auditing basic vulnerabilities and configurations.*   
**Technical Skill Level:** *Moderate.*   
**Frequency of Use:** *Occasional or course-dependent.*   
**Privileges:** *May have admin access depending on system policy.*   
**Modules Used:** *Primarily Security and Vulnerability Scan.*   
**Priority Level:** *High — aligns with the educational purpose of the tool.*   

**Secondary User Classes:**   
**3. Power Users / Tech Enthusiasts**   
**Role:** *Use the tool to maintain personal machines or optimize performance.*   
**Technical Skill Level:** *Moderate (comfortable with system settings but not scripting).*   
**Frequency of Use:** *Infrequent or as-needed basis.*   
**Privileges:** *Typically have admin rights on personal machines.*   
**Modules Used:** *Performance and Cleanup.*   
**Priority Level:** *Medium — important for usability and adoption but not the core focus.*   

**4. Casual Users (Non-Technical):**   
**Role:** *End users seeking a "one-click" cleanup or performance boost.*   
**Technical Skill Level:** *Basic.*   
**Frequency of Use:** *Rare.*   
**Privileges:** *May lack admin access.*   
**Modules Used:** *Mostly Cleanup; limited use of other tabs.*   
**Priority Level:** *Low — the tool will still function for this group, but with limited results or without admin-required features.*   

### 2.5 Assumptions and Dependencies
>The development and functionality of SwiftEdge Security rely on several assumptions and external dependencies. These are not guaranteed conditions but are considered true for the successful design, testing, and use of the software. If any of these assumptions prove to be invalid or these dependencies change, they may impact the final requirements or functionality of the system.

**Assumptions:**
- The end user will have administrative privileges on the Windows system to apply performance, security, and cleanup configurations.
- The operating environment is assumed to be Windows 11 (64-bit) or later, with PowerShell 5.1+ pre-installed.
- The system will have access to the internet when using the Vulnerability Scanner module to query external APIs.
- End users are expected to have basic to moderate familiarity with system maintenance tools and GUI-based applications.
- Windows will maintain consistent registry and service names (e.g., SysMain, DiagTrack) relevant to script logic.
- The PS2EXE module used to compile the application into an .exe will remain compatible with PowerShell 5.1 and Windows Forms functionality.

**Dependencies:**
- NVD API is used to retrieve CVE information for the Vulnerability Scanner module. This dependency includes:
- Continued availability and free access to the API.
- Stability of response formats (JSON).
- The application relies on several native Windows tools and services, including:
- powercfg, Get-Service, Stop-Service, Get-ItemProperty, and cleanmgr.
- All external scripts and modules (e.g., PS2EXE) must be downloadable and usable within the project’s timeframe.
- No commercial libraries, SDKs, or paid APIs are required or integrated into the system.

*These assumptions and dependencies form the basis for requirement decisions and software behavior. If any become invalid or unsupported, adjustments in requirements, testing, or distribution methods may be necessary.*

## 3. Requirements
> This section specifies the software product's requirements. It includes functional, interface, performance, security, and design requirements sufficient to guide the development and verification of SwiftEdge Security.

### 3.1 External Interfaces
> This subsection defines all inputs and outputs relevant to the SwiftEdge Security system, including their sources, formats, relationships, and presentation within the application.

#### 3.1.1 User interfaces
> Main user interface, system actions, and setup.

* **R-UI1:** Main GUI: (Windows Forms-based interface)(.NET appliance)
* **R-UI2:** Input: Mouse, Button Selection, Tab Changes, Check Boxes.
* **R-UI3:** Output: Text fields, system logs, message boxes, alerts.
* **R-UI4:** Range/Accuracy: Buttons/Check-Boxes/Fields mapped to corresponding PowerShell modules and commands with no overlapping functionality. 
* **R-UI5:** Units of Measure: Log Output: Hr,Min,Sec. Completion Time. 
* **R-UI6:** iming: All actions must be completed within a reasonable timeframe: 1 minute MAXIMUM. 15-30Sec Probable.
* **R-UI7:** Relationships: Tab changes will switch modules and therefore functionality. Buttons will trigger script execution with defined tasks.
* **R-UI8:** Screen Format/Layout: Four tabs: Performance/Security/Cleanup/Vulnerabilities. Buttons laid out next to each.
* **R-UI9:** Organization: Standard Windows Forms Layout .NET Appliance. Possible Adaptive Resolution and Autosizing. Neon-Accented Dark-Theme.
* **R-UI10:** Plain-Text Output: (Completion Status, Active Tasks, Module Type, Vulnerabilities Found)
* **R-UI11:** Command Format: NONE: No scripting is required by the user.
* **R-UI12:** End Messages: Success, Warning, Alerts, Notifications, Error, Popup, Status, Completion. Etc.

#### 3.1.2 Hardware interfaces
> Logical and physical characteristics of the hardware required for interface/system. Device types, data, interactions, etc. 
* **HW1:** Windows-Compatible Hardware: Desktop/Laptop amd64 Architecture.
* **HW2:** Input: System Information Tools: Registry, Powershell Commands, Scripts, Hardware Services.
* **HW3:** Output: Output to log file only if checked or necessary.
* **HW4:** Range/Accuracy: Must be compatible with Windows 11 (x64) (Latest).
* **HW5:** Units of Measure: Power mode settings, service status, disk space (TB, GB, MB), Timing Hr,Min,Sec.
* **HW6:** Timing: System changes should take no longer than 1 minute. The average should be between 15-30 seconds depending on the depth of command.
* **HW7:** Relationships: Hardware status is adjusted via Powershell, Windows APIs, and Registry Editor.
* **HW8:** Data Format: N/A (System-Level Commands) No User Interaction.
* **HW9:** Command Format: powercfg, Get-Service, Stop-Service, Regedit, Powershell Scripts(etc).
* **HW10:** End Messages: Visual Confirmation via GUI or output log. (Alert: Success/Failure)

#### 3.1.3 Software interfaces
> Connections between this product and other specific software components (name and version), including databases, operating systems, tools, libraries, and integrated commercial components. Identify the data items or messages coming into the system and going out and describe the purpose of each. Describe the services needed and the nature of communications. Refer to documents that describe detailed application programming interface protocols. Identify data that will be shared across software components.

* **SW1:** Software Interfaces: PowerShell, NVD API, Windows Registry, System Services, Powercfg, etc.
* **SW2:** Input: Internal PowerShell functions, API queries, Windows Regedit calls, powercfg changes.
* **SW3:** Output: GUI feedback, external logs(if checked), exported output.
* **SW4:** Range/Accuracy: API responses must return valid CVE that coincides with vulnerable software names and version numbers. PowerShell scripts must run without errors in a reasonable time frame.
* **SW5:** Units of Measure: CVSS scores, CVE numbers, number of CVEs, vulnerability version numbers, application data.
* **SW6:** Timing: Local commands < 1 minute. NVD API calls < 3 minutes (MAXIMUM)
* **SW7:** Relationships: Local software modules independent to system functions. Vulnerability module dependent on NVD API and internet.
* **SW8:** Data Format: JSON or other API format, TXT for exported logs, GUI Output.
* **SW9:** Command Format: PowerShell(Invoke-RestMethod), (Get-ItemProperty).
* **SW10:** End Messages: Success logs, CVE results, Vulnerability Results. 

### 3.2 Functional Requirements
> This section outlines the specific functional capabilities of SwiftEdge Security. Each function is organized by module and describes what the system must allow the user to do, the expected result, and any related conditions or triggers. All listed functions shall be accessible via the application's graphical user interface.

#### 3.2.1 General Functional Requirements
> These are some general functional requirements for SwiftEdge Security.

* **GFR1:** System should load Windows Forms GUI with four primary tabs: Performance, Security, Cleanup, and Vulnerability Scanning (Online).
* **GFR2:** System should prompt for administrative privileges when launching and/or running the programming requiring system-level modification.
* **GFR3:** The GUI should allow the user to execute each module's functions independently or together through an all-in-one button.
* **GFR4:** System should display success or failure messages based on the completion of scripts within the GUI for ALL Operations.
* **GFR5:** System should prevent module execution if the user lacks administrative privileges.

#### 3.2.2 Performance Module
> Performance Module Functional Requirements for SwiftEdge Security.

* **PM1:** System should allow the user to change the power plan to high using the powercfg or similar command.
* **PM2:** System should disable the SysMain (Superfetch) and Windows Search (WSearch) Services.
* **PM3:** System should disable Windows animations, transparency, and adjust text performance via Windows tools or Regedit.
* **PM4:** System should disable all background apps through user Regedit.
* **PM5:** System should disable Windows tips and hibernation.
* **PM6:** System should remove startup delay via Registry
* **PM7:** System should run defrag and optimize and enable monthly optimizations for peak performance. 

#### 3.2.3 Security Module
> Security module is separate from the Vulnerability Scanner and changes local settings without internet access. Hardening operations will be lightweight and non-invasive. 

* **SM1:** System should create a system restore point before applying any major security-related modifications in case of error or failure.
* **SM2:** System should disable SMBv1 via Windows Features if enabled.
* **SM3:** System should disable Remote Assistance and Remote Registry via services and Regedit.
* **SM4:** System Should enable All Windows Defender Security settings if disabled and ensure Memory Integrity is enabled.
* **SM5:** System should provide a confirmation message before applying any security hardening operations. (Lightweight)

#### 3.2.4 Cleanup Module
> This module is specifically designed for cleaning temporary files, trash, emptying the recycle bin, and removing bloatware applications. (Note: OneDrive users must uncheck the box for removing OneDrive.)

* **CM1:** System should clear all temporary files in %TEMP%, TEMP, and PREFETCH.
* **CM2:** System should clear all of the Windows Update Cache. (This helps reduce errors when performing Windows Updates)
* **CM3:** System should empty the Recycle Bin.
* **CM4:** System should remove built-in applications if checked for removal. (OneDrive, Xbox, Help, Feedback Center, etc)
* **CM5:** System should clear minor event logs in the event viewer by invoking related PowerShell commands.
* **CM6:** System should run disk cleanup with all items checked except the downloads folder.
* **CM7:** System should perform any extra commands required to clean extra or junk files from the system to improve organization and system performance.

#### 3.2.5 Vulnerability Scanner Module
> This module requires access to the internet to utilize the NIST NVD API for checking application version numbers and checking the CVE database for matching numbers.

* **VSM1:** System should retrieve a list of installed software and their version numbers from the Registry or by utilizing PowerShell GetInfo Commands.
* **VSM2:** System should use the NVD API to search for CVEs based on installed software names and version numbers.
* **VSM3:** System shall display each CVE found with the corresponding ID, Name, Severity (CVSS score), and a short summary.
* **VSM4:** System should allow the user to export vulnerability results to a file.
* **VSM5:** System should display a message if no internet connection is detected or the API fails.
* **VSM6:** System should alert the user in the GUI to update or remove vulnerable software. 

### 3.3 Quality of Service
> SwiftEdge Security should function quickly in real-time with zero delay. Users should be able to run SwiftEdge Security and be satisfied with the performance, security, and reliability of SwiftEdge Security. 

#### 3.3.1 Performance
> SwiftEdge Security must perform consistently and responsively under a range of hardware conditions, with specific emphasis on supporting low-to-mid-tier systems that are common in educational and small business environments. All performance requirements are focused on maintaining speed, resource efficiency, and responsiveness while executing system-level commands.

* **QOS-P1:** The GUI shall load within 30 seconds of system call and application launch. (4Gb RAM and minimum dual-core CPU).
* **QOS-P2:** Each module operation (Performance, Security, Cleanup, Vulnerability Scan) should be completed within a reasonable time frame. NOTE: Vulnerability scanning requires internet access and may run slower due to API calls or internet speed.
* **QOS-P3:** During active operations, the application should consume no more than 2Gb of RAM and should never exceed more than 25% of CPU usage. (NOTE: CPU usage will be higher on lower core CPU and older architectures)
* **QOS-P4:** Button presses and tab navigation should have no delay and respond within 1-5 seconds.
* **QOS-P5:** Initializing Script execution should take no longer than 5 seconds.
* **QOS-P6:** The application shall complete all performance optimization tasks in under 45 seconds when executed in full.
* **QOS-P7:** Security and Cleanup tabs will only take as much time as the system needs to process commands and run system-level tasks. 

#### 3.3.2 Security
> Security is a core component of SwiftEdge Security’s purpose and operation. The software is intended to harden a system against unnecessary services and known vulnerabilities, without introducing risk through its use. As such, security requirements focus on controlled access, safe modification of system settings, and privacy-respecting behavior

* **QOS-S1:** The application shall prompt for elevated (admin) permissions before launching and before running any system-level operations.
* **QOS-S2:** All security-related changes must be preceded by user confirmation (e.g. checking boxes before running the security module).
* **QOS-S3:** The application should create a System Restore Point before applying any heavy security modifications. (Protects against data loss).
* **QOS-S4**: Software: `SHOULD NOT UNDER ANY CIRCUMSTANCE COLLECT, STORE, OR TRANSMIT ANY PERSONALLY IDENTIFIABLE INFORMATION OR IDENTIFIABLE SYSTEM INFORMATION. EXCLUDING APPLICATION NAMES AND VERSION NUMBERS FOR VULNERABILITY SCANNING`.
* **QOS-S5:** Any registry changes or service modifications must be reversible and documented. (e.g. logs).
* **QOS-S6:** Application should not disable nor interfere with core system protections such as Defender or Firewall unless explicitly requested by the user.
* **QOS-S7:** The vulnerability scanner should only retrieve publicly available CVE data and should not upload any user software or device data.
* **QOS-S8:** Software must comply with security-related industry standards.
* **QOS-S9:** API responses used in the vulnerability scanner must be parsed and displayed read-only to the user without writing back to the system. 

#### 3.3.3 Reliability
> SwiftEdge Security was built on Reliability and Reusability to provide a fast, secure, and optimized experience.

* **QOS-R1:** 95% of all defined functions shall succeed without error on a clean Windows 11 install.
* **QOS-R2:** All functions shall include error handling to prevent partial or inconsistent application states.
* **QOS-R3:** If an error occurs, it shall be logged and presented to the user without halting the application or operation.
* **QOS-R4:** Application should verify the completion of critical operations with confirmation messages.
* **QOS-R5:** All modules must be isolated to prevent one module's failure from affecting another. (e.g., if cleanup failed, security remains unaffected). 

#### 3.3.4 Availability
> SwiftEdge Security was built with availability and the end-user in mind.

* **QOS-A1:** Application should run entirely offline, except for vulnerability scanning which requires an internet connection.
* **QOS-A2:** Offline mode should allow the software to detect and gracefully skip the vulnerability module while allowing other modules to function. (e.g., if no internet is found, gray out the Vulnerability Module Tab).
* **QOS-A3:** No online activation, subscriptions, or licensing is required.
* **QOS-A4:** .EXE file should be fully portable and able to run from a flash drive or a download folder without any extended installation. 

### 3.4 Compliance
> SwiftEdge Security shall comply with relevant technical standards, ethical data handling practices, and institutional policies to ensure safe and approved usage in both academic and organizational environments. The following compliance requirements ensure the software remains legal, auditable, and professionally acceptable for use.

* **CMP1:** Software should comply with all industry standards when used in all environments and avoid collection, storage, or transmission of personal data.
* **CMP2:** All logs generated by the application should not contain any personal information, system information, or configuration details.
* **CMP3:** CVE queries made through NVD API should use read-only methods.
* **CMP4:** Software should conform to PowerShell scripting standards.
* **CMP5:** Any exports should be generated in plain-text formats to be readable by the average user.
* **CMP6:** Any changes made to the Windows system should be traceable and reversible.
* **CMP7:** Vulnerability scanning should rely only on publicly accessible and reputable sources such as NIST's NVD.
* **CMP8:** Software should never bypass or override Windows Policy Settings unless otherwise specified by the user.
* **CMP9:** All third-party modules used must be open-source and publicly licensed.

### 3.5 Design and Implementation
> This section outlines how SwiftEdge Security will be structured, built, distributed, and maintained. It includes implementation constraints, portability expectations, cost, timeline, and proof-of-concept deliverables.

#### 3.5.1 Installation
> This section is specifically for understanding how this software will run. SwiftEdge Security does not require any extended installation.

* **D&I-I1:** Software should run directly as a compiled .EXE file created using PS2EXE from a carvable PowerShell script.
* **D&I-I2:** Software should not require any additional installation steps, frameworks, or runtimes unless out of date. (This may be required for the .NET framework utilized by Windows Forms GUI).
* **D&I-I3:** This tool should be compatible with systems that have PowerShell 5.1+ installed. (Installed by default on Windows 11).

#### 3.5.2 Distribution
> This section is specific to the distribution and open-source property of SwiftEdge Security.

* **D&I-D1:** Software should be distributed as a standalone executable .EXE. Script code will only be available through GitHub.
* **D&I-D2:** No internet connection should be required for operation except for the Vulnerability Scanner Module.
* **D&I-D3:** The executable may be optionally signed but not required for future use in managed environments. 

#### 3.5.3 Maintainability
> The Maintainability of SwiftEdge Security is based on code readability, updates, debugging, future enhancement, collaboration, and increased adaptability. This is why the open-source property of SwiftEdge Security makes it so great.

* **D&I-M1:** All code must follow industry formatting standards for formatting, naming, and overall structure.
* **D&I-M2:** The code should be modular, separating GUI logic from each script module.
* **D&I-M3:** Feature modules should be loosely coupled, allowing reuse or replacement with minimal disruption to the rest of the application.
* **D&I-M4:** Configuration variables should be easily editable and refined.
* **D&I-M5:** Scripts should detect and handle missing or deprecated features accordingly. (Note: However this may not apply to Windows 11 only compatibility).
* **D&I-M6:** Changelogs and version history shall be maintained within the source repository or packaging README.
* **D&I-M7:** Software should be easy to update including vulnerability databases to be ready for small changes and Windows updates
* **D&I-M8:** As Windows 11 continues to evolve, the software shall be designed to easily adapt to deprecations or changes in PowerShell cmdlets, Windows APIs, or system services.
* **D&I-M9:** The vulnerability scanning feature shall pull CVE data dynamically from the NVD API to ensure up-to-date threat detection without requiring updates to the software itself.
* **D&I-M10:** Periodic review of PowerShell commands, registry tweaks, and cleanup procedures shall be conducted to ensure compatibility with Windows Feature Updates and cumulative patches.

#### 3.5.4 Reusability
> SwiftEdge Security was designed with Reusability in mind and should thoughtfully demonstrate that throughout its implication.

* **D&I-R1:** Each functional module should be completely reusable as an independent PowerShell script.
* **D&I-R2:** Scripts should include standardized return codes and logging, enabling integration into pipelines or other systems.
* **D&I-R3:** Software used for NVD API, CVEs, or PowerShell Scripts should be isolated and maintain independent functionality.

#### 3.5.5 Portability
> Portability of SwiftEdge Security is based on a standalone .EXE this could be available on a USB, however, best cybersecurity practices should be followed and the .EXE should only be downloaded from the source repository.

* D&I-P1: The software should be portable within Windows 11 (x64) environments.
* D&I-P2: No cross-platform support offered. (No macOS or Linux Support).
* D&I-P3: Future implications of software may include a deprecated version specifically for Windows 10. (NOTE: Windows 10 no longer has Long-Term-Support LTS).

#### 3.5.6 Cost
> SwiftEdge Security believes that it should be free to keep your computer fast, secure, and optimized. Therefore SwiftEdge Security should not be under any circumstances sold or require payment.

* **D&I-C1:** All tools and libraries used should be free and open-source.
* **D&I-C2:** All tools and libraries should be readily accessible to the public.
* **D&I-C3:** The project as a whole should require no licensing, subscriptions, or commercial software unless otherwise indicated. 

#### 3.5.7 Deadline
 GUI completion 9/25/2025
 Testing 11/1/2025 - 11/30/2025
 Full project completion 01/30/2026

#### 3.5.8 Proof of Concept
> This section outlines the necessary items for SwiftEdge Security to be considered a proof of concept and must have some form of actual functionality before being distributed as a pre-release.

* **D&I-PC1:** Working Windows Forms GUI with tab-based navigation.
* **D&I-PC2:** Working Performance Module
* **D&I-PC3:** Working Cleanup Module
* **D&I-PC4:** Partially Assembled Security Module that will at the bare minimum output a security assessment.
* **D&I-PC5:** A Vulnerability Scanner that collects installed software info, retrieves information from the NVD API, and displays the results either in a text file or terminal.
* **D&I-PC6:** All functionality to-date should be wrapped in a single standalone executable .exe.
* **D&I-PC7:** Demonstration video, screenshots, or presentation on successful execution of each functioning module. 

## 4. Verification
> This section outlines the key validation and testing criteria for SwiftEdge Security. Each feature module must function independently and correctly without requiring external runtimes or manual configuration. The following checklist ensures that all performance, security, cleanup, and vulnerability scan operations perform as expected in the final executable version.

### 4.1 Product Testing and Verification

**General Application Behavior:**
| *Test Case*	                                   | *Expected Result*                                         |
| ---------------------------------------------- | --------------------------------------------------------- |
| Application launches without errors	           | Main GUI loads with all tabs and buttons functional       |
| GUI layout renders properly              	     | All text is visible, and no elements are clipped           |
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
| Indexing is turned off on C: drive	          | Indexing checkbox is cleared under drive properties |
| Explorer restart button functions	            | Explorer restarts without crashing                  |   

**Security Hardening Checklist:**
| *Test Case*	                                  | *Expected Result*                                                 | 
| --------------------------------------------- | ----------------------------------------------------------------- |
| SMBv1 is disabled	                            | Feature is not listed in Windows Features                         | 
| Remote assistance and registry are disabled	  | Services are stopped and the registry reflects the disabled state | 
| Windows Defender settings are updated	        | Tamper protection and cloud protection are enabled                | 
| A system restore point is created	            | Restore point is visible in the System Restore panel              | 
| Telemetry and tracking features are off	      | Data collection registry keys are set correctly                   | 

**Cleanup Module Checklist:**
| *Test Case*	                              | *Expected Result*                                       | 
| ----------------------------------------- | ------------------------------------------------------- |
| Temporary folders are emptied	            | %TEMP% and C:\Windows\Temp show a reduced file count    | 
| Event Viewer logs are cleared	            | Application/System/Security logs show no recent entries | 
| Windows Update cache is cleared	          | SoftwareDistribution\Download folder is empty           | 
| Preinstalled apps removed	                | App list no longer includes OneDrive/Xbox               | 
| RecycleBin is emptied	                    | Bin is confirmed to be empty                            |    

**Vulnerability Scanning Checklist:**
| *Test Case*	                               | *Expected Result*                                  | 
| ------------------------------------------ | -------------------------------------------------- |
| The installed software list is retrieved	 | The List shows app names and version numbers       | 
| NVD API is queried successfully	           | CVEs with IDs, summaries, and CVSS scores appear   | 
| Optional Vulners API returns valid         | JSON	Results that match expected software versions | 
| Export to TXT or CSV works                 | File is created with scan results                  |    
| No connection = graceful failure	         | App shows a message without crashing               |     

**Pass/Fail Criteria:**   \
*Pass:* All core modules are complete with no errors, changes confirmed, and scan results displayed or exported.

*Fail:* Application crashes do not apply expected system changes or do not retrieve vulnerability data when online.

## 5. References
> References listed below are split between documentation, GitHub repositories, and bad examples of software for inspired projects.

### 5.1 Documentation
Style Guide for SRD: [SRS-Template - Jam01](https://github.com/jam01/SRS-Template/tree/master)   
NIST NVD Developer Database: [NIST NVD Database](https://nvd.nist.gov/developers/start-here)   
NIST Data Feeds: [NIST NVD Data Feed](https://nvd.nist.gov/vuln/data-feeds#divJson20Feeds)
CVE Program: [CVE Program](https://www.cve.org/)   
Avast Security (GUI Inspiration): [Avast Security](https://www.avast.com/)   
Norton 360 (Software Version Scanning Inspiration): [Norton360](https://us.norton.com/products/norton-360-standard)   
Chris Titus WinUtil (Inspiration): [ChrisTitus - WinUtil](https://christitus.com/windows-tool/)   
RavenDevTeam Talon (Inspiration): [RavenDevTeam - Talon](https://ravendevteam.org/software/talon/)   

### 5.2 Github Repositories
PS2EXE PS1 Compiler: [PS2EXE - MScholtes](https://github.com/MScholtes/PS2EXE)   
Chris Titus WinUtil (Inspiration): [ChrisTitus - WinUtil](https://github.com/ChrisTitusTech/winutil)   
RavenDevTeam Talon (Inspiration): [RavenDevTeam - Talon](https://github.com/ravendevteam/talon)   

### 5.3 BAD EXAMPLES OF SOFTWARE
> Note: that the software listed below is either suspicious or malware, the design and idea behind the project was an original inspiration to making a secure optimizer. These are bad examples of performance or security optimizers and should not be installed or followed for creating secure optimizing software.

**Azurite Optimizer (WARNING: MALWARE)** (Although it is malware it was an original inspiration for this project due to the idea/design)  
**Due to Azurite being malware or suspicious activity, I will not be including the download link.**    

**8 PC Optimizers that are wrapped as malware.** [Beware of these 8 PC tune-up tools](https://www.fortect.com/malware-damage/pc-tuneup-software-malware/?srsltid=AfmBOopUsrZr6Lp9m9m6dvqGR7q1RNxFhEN8nOjlVGoIciYyk3rwpeQG)

**Talon - RavenDevTeam**
> Note: Talon by the RavenDevTeam was considered malware by AVs and other cybersecurity professionals. However, after digging and carving out the file it became clear that the reason Talon is flagged as malware by AVs is due to the wrapper used to wrap the Python code as an executable. Talon uses Nuitka which wraps the Python code and makes it difficult for AVs and other professionals to read and understand what the program does. However, RavenDevTeam has all of the code in the GitHub repository to view and go through to understand exactly what the program does.
John Hammond Analysis of Talon: [John Hammond - But is it malware?](https://youtu.be/1VdscQ8QCkY?si=ol7p8WguGWY5fv8E)   
ANYRUN Analysis on Talon: [ANYRUN Malware Analysis](https://any.run/report/c41c420a472489de4f13c849b3baeb169f6fa0924a2abbb7a4bce57eb08ae9fa/590776c0-408d-4877-a6fb-1aa00a5fdc22) 

**OTHER REFERENCES ADD HERE**  
