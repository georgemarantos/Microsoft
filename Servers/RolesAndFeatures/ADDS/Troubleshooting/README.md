## Active Directory Domain Services Troubleshooting
# Replication Issues:
AD DS replication issues occur when domain controllers fail to replicate data amongst each other, leading to inconsistent data across the network. Run the following PowerShell command to get a summary of replication status across all domain controllers.
```
Repadmin /replsummary
```

# Account Lockouts:
Run the following PowerShell command to get a list of all accounts that are currently locked out.
```
Search-ADAccount -LockedOut
```

# Failed User Authentications:
Run the following PowerShell command to view the last 10 failed login attempts.```
Get-WinEvent -FilterHashtable @{LogName='Security';Id=4625} -MaxEvents 10
```

# Check FSMO Role Holders:
Run the following PowerShell command to view the current FSMO role holders. 
```
Netdom query fsmo
```

# Time Synchronization Issues:
Run the following PowerShell command to view the current time configuration and status. 
```
W32tm /query /status
```
Also read the following [Time Synchronization](https://github.com/georgemarantos/Windows/blob/main/Servers/RolesAndFeatures/ADDS/Time-Synchronization.md) for more information about how time discrepancies between domain controllers and clients can lead to authentication failures. 

# Security Group Membership List:
Replace "GroupName" of the fo PowerShell with the name of the desired group view its members.
```
Get-ADGroupMember -Identity "GroupName"
```

# Analyzing Group Policy processing times:
Replace "<DomainControllerName> of the PowerShell script and then run to see total login time. (Note, currently not working.)
```
Get-WinEvent -ComputerName <DomainControllerName> -LogName 'Microsoft-Windows-GroupPolicy/Operational' | Where-Object { $_.Message -match "Total time" }
```