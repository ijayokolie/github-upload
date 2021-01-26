resource "azurerm_sql_server" "spldataserver" {
  name                         = var.sql_server
  resource_group_name          = azurerm_resource_group.rg.name
  location                     = azurerm_resource_group.rg.location
  version                      = "12.0"
  administrator_login          = var.sql_admin_user
  administrator_login_password = var.sql_password

  tags = {
    environment = var.environment
  }
}

resource "azurerm_storage_account" "spldatalog" {
  name                     = var.sql_log_storage
  resource_group_name      = azurerm_resource_group.rg.name
  location                 = azurerm_resource_group.rg.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
}

resource "azurerm_sql_database" "spldata" {
  name                = var.database_name
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
  server_name         = azurerm_sql_server.spldataserver.name

  extended_auditing_policy {
    storage_endpoint                        = azurerm_storage_account.spldatalog.primary_blob_endpoint
    storage_account_access_key              = azurerm_storage_account.spldatalog.primary_access_key
    storage_account_access_key_is_secondary = true
    retention_in_days                       = 6
  }



  tags = {
    environment = var.environment
  }
}