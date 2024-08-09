# Set Variables
$appname = "cys"
$securezone = "sec"
$region = "eastus2"
$appver = "01s"
$customer = "dmtn"

# Check if Tenant ID is set
if (-not $tenantId) {
    $subscriptionId = Read-Host -Prompt "Enter Tenant ID"
}

# Check if Subscription ID is set
if (-not $subscriptionId) {
    $subscriptionId = Read-Host -Prompt "Enter Subscription ID"
}

Write-Host "Variables Have Been Set."
