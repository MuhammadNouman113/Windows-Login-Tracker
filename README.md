# Windows-Login-Tracker
PowerShell script to fetch the last 50 unique logins in Windows
# Windows Login Tracker (PowerShell Script)
This PowerShell script retrieves the last 50 unique user logins on a Windows system, filtering out duplicate logins and system/service accounts.

## Features:
✅ Filters **only real user logins** (Interactive, RDP, Cached).  
✅ Excludes **system/service accounts** (`DWM-#`, `UMFD-#`).  
✅ Removes **duplicate logins per session**.  
✅ **Easy to use**—just run as Administrator.  

## Usage:
1. Open **PowerShell as Administrator**.  
2. Run the script:  
   ```powershell
   .\LoginHistory.ps1

