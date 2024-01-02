# Define variables for AD DS installation and promotion

$global:domainName = "yourdomain.com" # Set your domain name
$global:safeModeAdminPassword = ConvertTo-SecureString "YourSafeModePassword" -AsPlainText -Force # Set a safe mode admin password
$global:credential = Get-Credential # Get credential for domain

# Indicate that the variables have been set
$global:variablesConfigured = $true