# Import Variables from the first script
. ./kv-variables.ps1

# Set Key Vault and Resource Group Names
$resourceGroupName = "rg-$appname-$securezone-$customer-$region-$appver"
$keyVaultName = "kv-$appname-$securezone-$customer-$appver"

# Check if Key Vault Name is longer than 24 characters
if ($keyVaultName.Length -gt 24) {
    Write-Host "Key Vault Name too long. The maximum allowed length is 24 characters."
    exit
}

# Check if the resource group exists
$resourceGroup = Get-AzResourceGroup -Name $resourceGroupName -ErrorAction SilentlyContinue
if (-not $resourceGroup) {
    Write-Error "No Resource Group Found! Create a resource group first with proper tagging policy and then run script again"
    exit
}

# Get the Key Vault
$keyVault = Get-AzKeyVault -ResourceGroupName $resourceGroupName -VaultName $keyVaultName

# Create Private Link Service Connection object
$privateLinkServiceConnection = @{
    Name                   = "connection-to-$keyVaultName"
    PrivateLinkServiceId   = $keyVault.ResourceId
    GroupIds               = @("vault")
    RequestMessage         = "Auto-approving connection to $keyVaultName"
}

# Convert hashtable to a PSPrivateLinkServiceConnection object
$privateLinkServiceConnectionObj = New-Object -TypeName Microsoft.Azure.Commands.Network.Models.PSPrivateLinkServiceConnection -Property $privateLinkServiceConnection

# Create the Private Endpoint
$privateEndpoint = New-AzPrivateEndpoint -ResourceGroupName $resourceGroupName `
    -Name $privateEndpointName `
    -Location $region `
    -Subnet $subnetId `
    -PrivateLinkServiceConnection $privateLinkServiceConnectionObj

Write-Host "Created Private Endpoint '$privateEndpointName' and linked it to Key Vault '$keyVaultName'."