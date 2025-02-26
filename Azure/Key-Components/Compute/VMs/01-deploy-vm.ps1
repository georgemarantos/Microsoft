# Deploy Virtual Machine to Azure

# Load Variables
. .\00-vm-variables.ps1

# Debug: Print out the imported variables
Write-Host "VM Name: $vmName" -ForegroundColor Green
Write-Host "Secure Zone: $securezone" -ForegroundColor Green
Write-Host "Region: $region" -ForegroundColor Green
Write-Host "App Version: $appver" -ForegroundColor Green
Write-Host "Customer: $customer" -ForegroundColor Green

# Check if variables are set
if (-not $vmName) { Write-Error "vmName is not set." }
if (-not $securezone) { Write-Error "securezone is not set." }
if (-not $region) { Write-Error "region is not set." }
if (-not $appver) { Write-Error "appver is not set." }
if (-not $customer) { Write-Error "customer is not set." }

# Set Variables
$resourceGroupName = "rg-$vmName-$securezone-$customer-$region-$appver"

# Construct VM Name with Character Limit
$vmName = "vm-$vmName-$appver"
if ($vmName.Length -gt 15) {
    Write-Host "Error: VM name exceeds 15 characters. Adjust vmName or appver." -ForegroundColor Red
    exit
}

# Check if Resource Group Exists
$rg = Get-AzResourceGroup -Name $resourceGroupName -ErrorAction SilentlyContinue
if (-not $rg) {
    Write-Host "Resource group '$resourceGroupName' does not exist. Creating..."
    New-AzResourceGroup -Name $resourceGroupName -Location $region
}

# Define VM Configuration
$vmConfig = New-AzVMConfig -VMName $vmName -VMSize $vmSize

# Create a Managed OS Disk
$osDisk = New-AzDiskConfig -SkuName "Premium_LRS" -Location $location -CreateOption "FromImage"

# Set OS Type
if ($osType -eq "Windows") {
    $cred = Get-Credential -Message "Enter local admin credentials for the Windows VM"
    Set-AzVMOperatingSystem -VM $vmConfig -Windows -ComputerName $vmName -Credential $cred
} elseif ($osType -eq "Linux") {
    $cred = Get-Credential -Message "Enter SSH credentials for the Linux VM"
    Set-AzVMOperatingSystem -VM $vmConfig -Linux -ComputerName $vmName -Credential $cred
} else {
    Write-Host "Invalid OS type specified. Choose 'Windows' or 'Linux'." -ForegroundColor Red
    exit
}

# Set Image Type
if ($osType -eq "Windows") {
    Set-AzVMSourceImage -VM $vmConfig -PublisherName "MicrosoftWindowsServer" -Offer "WindowsServer" -Skus "$windowsSku" -Version "latest"
} else {
    Set-AzVMSourceImage -VM $vmConfig -PublisherName "$LinuxPublisher" -Offer "$offer" -Skus "$LinuxSku" -Version "latest"
}

# Configure Networking (DHCP, No Public IP, No NSG)
$vnet = Get-AzVirtualNetwork -Name $vnetName -ResourceGroupName $vnetResourceGroup
$subnet = Get-AzVirtualNetworkSubnetConfig -VirtualNetwork $vnet | Where-Object { $_.Name -eq $subnetName }
$nic = New-AzNetworkInterface -Name "$vmName-nic" -ResourceGroupName $resourceGroupName -Location $region -SubnetId $subnet.Id
Add-AzVMNetworkInterface -VM $vmConfig -Id $nic.Id
Set-AzVMBootDiagnostic -VM $vmConfig -Enable


# Deploy VM
New-AzVM -ResourceGroupName $resourceGroupName -Location $region -VM $vmConfig

Write-Host "Virtual Machine '$vmName' deployment complete."
