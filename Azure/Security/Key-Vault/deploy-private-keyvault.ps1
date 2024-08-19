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

# Create the Key Vault
Write-Host "Creating Key Vault: $keyVaultName"
New-AzKeyVault -ResourceGroupName $resourceGroupName `
    -VaultName $keyVaultName `
    -Location $region `
    -Sku $sku `
	-PublicNetworkAccess Disabled `
	-EnablePurgeProtection
	
# Assign RBAC Role to a specific user or group 
$roleDefinitionName = "Key Vault Administrator"

# Assign RBAC Role to a specific user or group 
$roleDefinitionName = "Key Vault Administrator"
$groupName = "Azure SecAdmins" 

# Get the Object ID of the Azure AD group
$group = Get-AzADGroup -DisplayName $groupName
if (-not $group) {
    Write-Host "Azure AD group '$groupName' not found."
    exit
}

$groupId = $group.Id

# Assign the role to the Azure AD group
Write-Host "Assigning role '$roleDefinitionName' to Azure AD group '$groupName' for Key Vault: $keyVaultName"
New-AzRoleAssignment -RoleDefinitionName $roleDefinitionName `
    -PrincipalId $groupId `
    -Scope "/subscriptions/$($subscriptionId)/resourceGroups/$resourceGroupName/providers/Microsoft.KeyVault/vaults/$keyVaultName"
	
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
Write-Host "Creating Private Endpoint '$privateEndpointName' and linking to Key Vault '$keyVaultName'."
$privateEndpoint = New-AzPrivateEndpoint -ResourceGroupName $resourceGroupName `
    -Name $privateEndpointName `
    -Location $region `
    -Subnet $subnetId `
    -PrivateLinkServiceConnection $privateLinkServiceConnectionObj

Write-Host "Key Vault '$keyVaultName' has been successfully created with private endpoint '$privateEndpointName'."