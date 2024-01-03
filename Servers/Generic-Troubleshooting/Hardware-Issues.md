# Hardware Issue Investigation 

## Check Hard Disk Health:
To check the operational and health status of physical disks.
```
Get-PhysicalDisk | Select-Object DeviceId, OperationalStatus, HealthStatus
```

## Run Disk Checks:
Checks the disk for errors and attempts to repair them.
```
chkdsk /f /r
```