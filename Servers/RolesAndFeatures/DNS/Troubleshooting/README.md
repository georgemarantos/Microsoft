## DNS Troubleshooting
# Check DNS Server Service Status:
Run the following PowerShell command to ensure that the DNS Server service is running on the server.
```Get-Service -Name DNS```

# Review DNS Server Configuration:
Run the following PowerShell command to check the configuration of the DNS server for any misconfigurations.
```Get-DnsServer | Format-List *```

# Verify DNS Forwarders Configuration:
Run the following PowerShell command to checks the configuration of the DNS server for any misconfigurations.
```Get-DnsServer | Format-List *```

# Get-DnsServerForwarder:
Run the following PowerShell command to ensures that DNS forwarders are correctly configured and operational. 
```Get-DnsServerForwarder```

# Examine DNS Zones for Issues:
Run the following PowerShell command to lists all zones on the DNS server to check for any misconfigurations or issues.
```Get-DnsServerZone```

# Use DCDiag to Test DNS:
Run the following PowerShell command for diagnostics specifically for DNS on the domain controller, checking for issues and ensuring DNS records are properly registered.
```dcdiag /test:dns /dnsrecordregistration```

# Check AD DS SRV Records:
Replace "DomainName" of the PowerShell script command to verify the SRV records needed for AD DS operations. (Not working as I want, check and update)
```nslookup```
```set type=srv```
```_ldap._tcp.dc._msdcs.<DomainName>```