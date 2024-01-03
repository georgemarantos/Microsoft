## Network Connectivity Troubleshooting

# Advanced Ping Diagnostics
Continuously ping with a specific packet size to diagnose MTU issues or intermittent packet loss.
```
ping -t -l 1400 <DestinationIP>
```

# Examine Network Interface Performance:
View detailed statistics for network adapters, including errors and discards.
```
Get-NetAdapterStatistics
```

# Use Netstat for Port and Connection Analysis:
View active connections and listening ports to identify unexpected connections or traffic.
```
netstat -ano
```

# Failed User Authentications:
Run the following PowerShell command to view the last 10 failed login attempts.
```
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

Also read the following [Time Synchronization](https://github.com/georgemarantos/Windows/blob/main/Servers/RolesAndFeatures/ADDS/Time-Synchronization.md) article for more information about how time discrepancies between domain controllers and clients can lead to authentication failures. 

# Security Group Membership List:
Replace "GroupName" of the fo PowerShell with the name of the desired group view its members.
```
Get-ADGroupMember -Identity "GroupName"
```

# Check FSMO Role Holders:
Run the following PowerShell command to show applied group policies on a client.
```
gpresult /R
```

# Review User Authentication Issues:
Run the following PowerShell command to checks the secure channel between a computer and its domain.
```
Test-ComputerSecureChannel -Verbose
```

# Analyze Kerberos Tickets:
Run the following PowerShell command to lists Kerberos tickets to troubleshoot authentication issues.
```
klist tickets
```

# Analyzing Group Policy processing times:
Replace "<DomainControllerName> of the PowerShell script and then run to see total login time. (Note, currently not working.)
```
Get-WinEvent -ComputerName <DomainControllerName> -LogName 'Microsoft-Windows-GroupPolicy/Operational' | Where-Object { $_.Message -match "Total time" }
```