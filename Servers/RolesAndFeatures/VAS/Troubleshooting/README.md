## Volume Activation Services Troubleshooting
# Check Activation Status:
Run the following PowerShell command dsplay detailed license and activation information for the Windows system you are trying to activate.
```slmgr.vbs /dli```

# Check KMS Server Activation and Status:
Run the following PowerShell command on the KMS server to check the detailed license and activation status, including the count of machines that have requested activation.
```slmgr.vbs /dlv```

# Force an Attempt to Activate:
Run the following PowerShell command to to force the Windows system to attempt online activation immediately.
```slmgr.vbs /ato```

# Check DNS for KMS Service Record
Run the following PowerShell command on the Windows system to check DNS for the presence of a KMS service record.
```nslookup -type=srv _vlmcs._tcp```

# Verify KMS Port is Open and Listening
Run the following PowerShell command on the Windows system to check if the KMS server is listening on the default port 1688.
```netstat -ano | findstr :1688``

# Review Configuration of Client-Side KMS Activation Settings
Replace <KMS_FQDN> of the PowerShell script command and run on the client side to set the specific KMS server to be used for activation. 
```slmgr.vbs /skms <KMS_FQDN>```