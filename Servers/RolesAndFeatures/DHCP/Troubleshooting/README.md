# DHCP Troubleshooting
## Check DNS Server Service Status:
Run the following PowerShell command to ensure that the DHCP Server service is running on the server.
```
Get-Service -Name DHCPServer
```

## Review DNS Server Configuration:
Run the following PowerShell command to check the configuration of the DHCP server for any misconfigurations.
```
Get-DhcpServerv4Scope
```

## Validate DHCP Scope Statistics:
Run the following PowerShell command to get statistics for each DHCP scope to check for exhaustion of IP addresses.
```
Get-DhcpServerv4ScopeStatistics
```

## Check IP Address Conflicts
Replace <ScopeID> of the PowerShell script command to detects IP address conflicts within a specific DHCP scope. 
```
Get-DhcpServerv4Lease -ScopeId <ScopeID> -ConflictDetect
```