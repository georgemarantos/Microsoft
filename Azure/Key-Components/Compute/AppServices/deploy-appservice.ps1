# Import variables from app-variables.ps1
. ./app-variables.ps1

# Debug: Print out the imported variables
Write-Host "Tenant ID: $tenantId"
Write-Host "App Name: $appname"
Write-Host "Secure Zone: $securezone"
Write-Host "Region: $region"
Write-Host "App Version: $appver"
Write-Host "Customer: $customer"

# Set Variables
$resourceGroupName = "rg-$appname-$securezone-$customer-$region-$appver"
$appServicePlanName = "asp-$appname-$securezone-$customer-$region-$appver"
$appServiceName = "as-$appname-$securezone-$customer-$region-$appver"

# Debug: Print out the imported variables
Write-Host "Resource Group Name: $resourceGroupName"
Write-Host "App Service Plan: $appServicePlanName"
Write-Host "App Service Name: $appServiceName"

# Check if the resource group exists
$resourceGroup = Get-AzResourceGroup -Name $resourceGroupName -ErrorAction SilentlyContinue
if (-not $resourceGroup) {
    Write-Error "Error, create resource group with proper tagging and then run script again"
    exit
}

# Create the App Service Plan
try {
    $appServicePlan = New-AzAppServicePlan -Name $appServicePlanName `
                                           -ResourceGroupName $resourceGroupName `
                                           -Location $region `
                                           -Tier "Basic" `
                                           -NumberofWorkers 1 `
                                           -WorkerSize "Small"
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
