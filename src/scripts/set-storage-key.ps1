Param(
    [string] [Parameter(Mandatory=$true)] $TFBackendResourceGroup,
    [string] [Parameter(Mandatory=$true)] $terraformstorageaccount
)

$key=(Get-AzStorageAccountKey -ResourceGroup $TFBackendResourceGroup -Name $terraformstorageaccount).Value[0]

Write-Host "#vso[variable task.setvariable storagekey]$key"