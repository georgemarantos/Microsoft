# Set Application Variables
$appname = "gmarantos"
$securezone = "development"
$region = "eastus2"
$appver = "01"
$customer = "xxxx"

# Set Resource Variables
$sku = "Standard"

# Set Networking Variables
$vnet = "vnet-gmarantos-sandbox-eastus2"
$subnet = "default"
$privateEndpointResourceGroup = "rg-gmarantos-development-eastus2"

# Check if Subscription ID is set
if (-not $subscriptionId) {
    $subscriptionId = Read-Host -Prompt "Enter Subscription ID"
}

Write-Host "Variables Have Been Set."