# Virtual Machine Variables Configuration

# Set Naming Variables
$vmName = "gmarantos"
$securezone = "development"
$region = "eastus2"
$appver = "01"
$customer = "xxxx"

# VM Sizing Options
# - Standard_B1s: Low-cost, minimal performance
# - Standard_D2s_v3: Balanced performance for general workloads
# - Standard_E4s_v3: Memory-optimized for high-memory applications
# - Standard_F4s_v2: Compute-optimized for intensive CPU tasks
$vmSize = "Standard_D2s_v3"  # Choose appropriate VM size

# OS Type (Windows or Linux)
$osType = "Windows"  # Choose 'Windows' or 'Linux'

# Windows Sku Options
$windowsSku = "2022-Datacenter-Azure-Edition" #Choose from 2022-Datacenter-Azure-Edition, 2019-Datacenter, 2016-Datacenter 

# Linux Sku Options 
$LinuxPublisher = "RedHat" # Choose 'RedHat' or 'resf'
$offer = "RHEL" # Choose 'RHEL' or 'rockylinux-x86_64'
$LinuxSku = "9-lvm-gen2" # Choose '9-lvm-gen2' or '9-lvm'

# Network Configuration
$vnetName = "vnet-gmarantos-sandbox-eastus2"
$subnetName = "default"
$vnetResourceGroup = "rg-gmarantos-development-eastus2"

Write-Host "VM Variables Have Been Set."
