# How to begin with terraform

# install powershellCore6 on ubuntu
sudo update update && sudo apt -y install wget
wget -q https://packages.microsoft.com/config/ubuntu/18.04/packages-microsoft-prod.deb
sudo dpkg -i packages-microsoft-prod.deb
sudo apt update
sudo apt -y install powershell
sudo pwsh

# install AzureRM module on PoshCore
Install-Module Az -Confirm:$false
Import-Module Az
Login-AzureRMAccount

# Account               SubscriptionName TenantId                             Environment
# -------               ---------------- --------                             -----------
# ian.ovenell@gmail.com                  ade4823d-fc33-40e5-b96d-f798933de10f AzureCloud


# terraform needs an Azure AD service principal; create using the following bash/Azure CLI commands
ARM_SUBSCRIPTION_ID=yourSubscriptionID
az ad sp create-for-rbac --role="Contributor" --scopes="/subscriptions/$ARM_SUBSCRIPTION_ID"

# 