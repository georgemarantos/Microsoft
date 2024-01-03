# Windows Update Troubleshooting

## Get-WindowsUpdateLog:
Generates a readable Windows Update log for review.
```
Get-WindowsUpdateLog
```

## Restart Windows Update Service:
Restarts the Windows Update service, which can resolve temporary glitches.
```
net stop wuauserv && net start wuauserv
```

## Clear Windows Update Cache:
Clears the update cache and forces Windows Update to recheck and redownload updates.
```
net stop wuauserv
del %windir%\SoftwareDistribution\DataStore\*.* /q
del %windir%\SoftwareDistribution\Download\*.* /q
net start wuauserv
```

## Use DISM Tool:
Repairs the Windows image and resolves issues with the Windows Update process.
```
DISM.exe /Online /Cleanup-image /Restorehealth
```

## Manually Install Update with DISM:
Replace <KBnumber> with KBnumber you need to manually install.
```
DISM.exe /Online /Add-Package /PackagePath:c:\<KBnumber>.cab
```

## Check Services Dependencies:
Checks the status of the Windows Update service and its dependencies.
```
sc queryex wuauserv
```