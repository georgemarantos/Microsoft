# Security Vulnerabilities and Breaches Investigation 

## Review Recent Account Activities:
Checks for recent failed login attempts or unusual account activities.
```
Get-EventLog Security | Where-Object {$_.EntryType -eq "FailureAudit"}
```

## Analyze Running Processes:
Lists current running processes to identify any unfamiliar or suspicious processes.
```
Get-Process
```

## Check for Unusual Network Connections:
Displays all network connections and listening ports, along with the associated process.
```
netstat -ano
```

## Inspect Scheduled Tasks:
Reviews active scheduled tasks for any that are unexpected or unauthorized.
```
Get-ScheduledTask | Where-Object {$_.State -ne "Disabled"}
```

## Review Services Running on the Server:
Identifies all running services to spot any unusual or unauthorized services.
```
Get-Service | Where-Object {$_.Status -eq "Running"}
```

## Check for Unusual Registry Entries:
Looks for suspicious entries in registry run keys.
```
reg query HKLM\Software\Microsoft\Windows\CurrentVersion\Run
reg query HKLM\Software\Microsoft\Windows\CurrentVersion\RunOnce
```

## Audit User Accounts and Groups:
Reviews local users and group memberships for unauthorized changes.
```
Get-LocalUser | Select-Object Name,Enabled,LastLogon
Get-LocalGroupMember Administrators
```

## Analyze Disk for Suspicious Files:
Searches for executable and DLL files, which can help locate malicious files.
```
dir /s /b /a:-d | findstr /i "exe dll"
```