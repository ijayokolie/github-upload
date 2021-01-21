terraform {
  backend "azurerm" {
    resource_group_name  = "test-rg-tfstate-dev-uks"
    storage_account_name = "testdevtf"
    container_name       = "tfstate"
    key                  = "terraform.tfstate"    
  }
}