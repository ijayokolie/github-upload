Param(
    [string] [Parameter(Mandatory=$true)] $Location,
    [string] [Parameter(Mandatory=$true)] $TFBackendResourceGroup,
    [string] [Parameter(Mandatory=$true)] $terraformstorageaccount,
    [string] [Parameter(Mandatory=$false)] $SKU  
)

az group create --location $Location --name $TFBackendResourceGroup

az storage account create --name $terraformstorageaccount --resource-group $TFBackendResourceGroup --location $Location --sku $SKU

az storage container create --name tfstate --account-name $terraformstorageaccount

az storage account keys list -g $TFBackendResourceGroup -n $terraformstorageaccount