# Script to install AD DS role and promote server to a domain controller

# Check if variables.ps1 has been run
try {
    if (!$global:variablesConfigured) {
        throw "Variables not configured. Please run variables.ps1 first."
    }
} catch {
    Write-Error $_.Exception.Message
    exit
}

# Install the AD DS role
Install-WindowsFeature -Name AD-Domain-Services -IncludeManagementTools

# Import AD DS deployment module
Import-Module ADDSDeployment

# Promote the server to a domain controller
Install-ADDSDomainController `
    -NoGlobalCatalog:$false `
    -CreateDnsDelegation:$false `
    -Credential $global:credential `
    -CriticalReplicationOnly:$false `
    -DatabasePath "C:\Windows\NTDS" `
    -DomainName $global:domainName `
    -InstallDns:$true `
    -LogPath "C:\Windows\NTDS" `
    -NoRebootOnCompletion:$false `
    -SiteName "Default-First-Site-Name" `
    -SysvolPath "C:\Windows\SYSVOL" `
    -Force:$true `
    -SafeModeAdministratorPassword $global:safeModeAdminPassword

# Restart the server after the role installation and promotion
Restart-Computer