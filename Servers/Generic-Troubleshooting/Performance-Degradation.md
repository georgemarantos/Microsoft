# Performance Degradation Troubleshooting

## Check for Disk Space Issues
Checks disk space usage on the C: drive.
```
Get-PSDrive C | Select-Object Used, Free
```

## Verify Server Uptime:
Determines how long the server has been running since the last reboot.
```
systeminfo | find "System Boot Time"
```