# Import Variables from the first script
. ./sql-variables.ps1

# Set SQL Server and Database Names
$resourceGroupName = "rg-$appname-$securezone-$customer-$region-$appver"
$sqlServerName = "sql-$appname-$securezone-$customer-$region-$appver"
$sqlDatabaseName = "db-$appname-$securezone-$customer-$region-$appver"

# Check if the resource group exists
$resourceGroup = Get-AzResourceGroup -Name $resourceGroupName -ErrorAction SilentlyContinue
if (-not $resourceGroup) {
    Write-Error "No Resource Group Found! Create a resource group first with proper tagging policy and then run script again"
    exit
}

# Set Entra ID Security Group as SQL Server Admin
$groupDn = (Get-AzADGroup -DisplayName "Cloud DBAdmins").DisplayName

# Create the SQL Server
Write-Host "Creating Azure SQL Server: $sqlServerName"
New-AzSqlServer -ResourceGroupName $resourceGroupName -ExternalAdminName $groupDn `
    -ServerName $sqlServerName `
    -Location $region `
    -ServerVersion "12.0" `
	-EnableActiveDirectoryOnlyAuthentication

# Set Entra ID Security Group as SQL Server Admin
$groupId = (Get-AzADGroup -DisplayName "Cloud DBAdmins").Id

Set-AzSqlServerActiveDirectoryAdministrator -ResourceGroupName $resourceGroupName `
    -ServerName $sqlServerName `
    -DisplayName "Cloud DBAdmins" `
    -ObjectId $groupId `

# Create the SQL Database with Standard DTU model (S2: 10 DTUs and 250 GB size)
Write-Host "Creating Azure SQL Database: $sqlDatabaseName"
New-AzSqlDatabase -ResourceGroupName $resourceGroupName `
    -ServerName $sqlServerName `
    -DatabaseName $sqlDatabaseName `
    -RequestedServiceObjectiveName "S2" `
    -MaxSizeBytes 250GB `
    -Edition "Standard" `
    -BackupStorageRedundancy "Local"

Write-Host "Azure SQL Server and Database have been created successfully, with 'Cloud DBAdmins' as the admin."
