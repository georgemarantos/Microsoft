$region = "eastus2"

# Set Application Naming Variables
if (-not $appname) {
    $appname = Read-Host -Prompt "Enter Application Name"
}
if (-not $securezone) {
    $securezone = Read-Host -Prompt "Enter security zone such as: sec, idmz, or office"
}
if (-not $region) {
    $region = Read-Host -Prompt "This should default to eastus2"
}
if (-not $appver) {
    $appver = Read-Host -Prompt "Enter version of the application, as in 01, 02, or 03"
}
if (-not $customer) {
    $customer = Read-Host -Prompt "Enter customer or affiliate name"
}
$resourceGroupName = "rg-$appname-$securezone-$customer-$region-$appver"
$appServicePlanName = "asp-$appname-$securezone-$customer-$region-$appver"
$appServiceName = "as-$appname-$securezone-$customer-$region-$appver"

# Check if the resource group exists
$resourceGroup = Get-AzResourceGroup -Name $resourceGroupName -ErrorAction SilentlyContinue
if (-not $resourceGroup) {
    Write-Error "Error, create resource group with proper tagging and then run script again"
    exit
}

# Set App Service Variables
if (-not $tier) {
    $tier = Read-Host -Prompt "Set App Service tier by choosing from: Free, Basic, Standard, Premium, Isolated"
}
if (-not $workers) {
    $workers = Read-Host -Prompt "Input number of workers: 1 worker instance is default for Basic tier while more workers are applicable to Standard, Premium, and Isolated tiers"
}
if (-not $size) {
    $size = Read-Host -Prompt "Choose Compute Size from choices of: Small, Medium, Large, ExtraLarge"
}


# Create the App Service Plan
try {
    $appServicePlan = New-AzAppServicePlan -Name $appServicePlanName `
                                           -ResourceGroupName $resourceGroupName `
                                           -Location $region `
                                           -Tier $tier `
                                           -NumberofWorkers $workers `
                                           -WorkerSize $size
} catch {
    Write-Error "Failed to create App Service Plan: $_"
    exit
}

# Create the App Service
try {
    $appService = New-AzWebApp -Name $appServiceName `
                               -ResourceGroupName $resourceGroupName `
                               -Location $region `
                               -AppServicePlan $appServicePlan.Id
} catch {
    Write-Error "Failed to create App Service: $_"
    exit
}

# Enable HTTPS-only
if ($appService) {
    Set-AzWebApp -ResourceGroupName $resourceGroupName `
                 -Name $appServiceName `
                 -HttpsOnly $true
} else {
    Write-Error "App Service creation failed, cannot set HTTPS-only."
}

Write-Host "App Service '$appServiceName' has been successfully created on App Service Plan '$appServicePlanName'."
