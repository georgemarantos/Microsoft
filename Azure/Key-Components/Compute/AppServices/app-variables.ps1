# Set Application Variables
$appname = "gmarantos"
$securezone = "development"
$region = "eastus2"
$appver = "01"
$customer = "xxx"

# Set Resource Variables
$Tier = "Basic"
$NumberofWorkers = "1" 
$WorkerSize = "Small"

# Set Networking Variables
$vnet = "vnet-gmarantos-sandbox-eastus2"
$subnet = "default"
$privateEndpointResourceGroup = "rg-gmarantos-development-eastus2"

# Check if Subscription ID is set
if (-not $subscriptionId) {
    $subscriptionId = Read-Host -Prompt "Enter Subscription ID"
}

Write-Host "Variables Have Been Set."