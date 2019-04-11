# How to begin with terraform

# install powershellCore6 on ubuntu
sudo update update && sudo apt -y install wget
wget -q https://packages.microsoft.com/config/ubuntu/18.04/packages-microsoft-prod.deb
sudo dpkg -i packages-microsoft-prod.deb
sudo apt update
sudo apt -y install powershell
sudo pwsh

# install powershellCore6 on Kali
apt update && apt -y install curl gnupg apt-transport-https
wget https://github.com/PowerShell/PowerShell/releases/download/v6.2.0/powershell_6.2.0-1.debian.9_amd64.deb
sudo dpkg -i powershell_6.2.0-1.debian.9_amd64.deb
sudo apt-get install -f
sudo pwsh

# install AzureRM module on PoshCore
Install-Module Az -Confirm:$false
Import-Module Az
Login-AzureRMAccount

# Account               SubscriptionName TenantId                             Environment
# -------               ---------------- --------                             -----------
# ian.ovenell@gmail.com                  ade4823d-fc33-40e5-b96d-f798933de10f AzureCloud


# terraform needs an Azure AD service principal; create using the following bash/Azure CLI commands
$AzSubscription = Get-AzSubscription
$ARM_SUBSCRIPTION_ID=$AzSubscription.Id
$AzureServicePrincipal = New-AzADServicePrincipal -role "Contributor" -scope "/subscriptions/$ARM_SUBSCRIPTION_ID"

# setting variables
echo "Setting environment variables for Terraform"
$ARM_SUBSCRIPTION_ID=$ARM_SUBSCRIPTION_ID
$ARM_CLIENT_ID=$AzureServicePrincipal.ApplicationId
$ARM_CLIENT_SECRET=[System.Runtime.InteropServices.marshal]::PtrToStringAuto([System.Runtime.InteropServices.marshal]::SecureStringToBSTR($AzureServicePrincipal.Secret))
$ARM_TENANT_ID=$AzSubscription.TenantId

# Not needed for public, required for usgovernment, german, china
$ARM_ENVIRONMENT = "public"

$RANDOM = Get-Random -Maximum 999999 -Minimum 111111
$RESOURCE_GROUP_NAME = "terraformstate"
$STORAGE_ACCOUNT_NAME = "tfstate$RANDOM"
$CONTAINER_NAME = "tfstate"
$LOCATION = "westus"
 
# Create resource group
New-AzResourceGroup -Name "$RESOURCE_GROUP_NAME" -Location $LOCATION
 
# Create storage account
$storageAccount = New-AzStorageAccount -ResourceGroupName "$RESOURCE_GROUP_NAME" -Name "$STORAGE_ACCOUNT_NAME" -SkuName "Standard_LRS" -Kind "BlobStorage" -Location "$LOCATION" -AccessTier Hot

# set account context
$ctx = $storageAccount.Context

# Get storage account key
$ACCOUNT_KEY = Get-AzStorageAccountKey -ResourceGroupName "$RESOURCE_GROUP_NAME" -Name "$STORAGE_ACCOUNT_NAME" 
 
# Create blob container
New-AzStorageContainer -Name "$CONTAINER_NAME" -Context $ctx

# Create Azure KeyVault and store secret
$AZ_VAULT = New-AzKeyVault -Name "AzKeys$RANDOM" -ResourceGroupName "$RESOURCE_GROUP_NAME" -Location "$LOCATION" -EnabledForDeployment

# Set up data plane permissions for the Contoso Security Team role
Set-AzKeyVaultAccessPolicy -VaultName "$AZ_VAULT.VaultName" -ObjectId (Get-AzADGroup -SearchString 'Contoso Security Team')[0].Id -PermissionsToKeys backup,create,delete,get,import,list,restore -PermissionsToSecrets get,list,set,delete,backup,restore,recover,purge
