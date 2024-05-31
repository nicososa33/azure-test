
resource "azurerm_storage_account" "example" {
  name                     = var.azurerm_storage_account.name #"examplesa"
  resource_group_name      = var.azurerm_storage_account.resource_group_name #azurerm_resource_group.example.name
  location                 = var.azurerm_storage_account.location #azurerm_resource_group.example.location
  account_tier             = var.azurerm_storage_account.account_tier #"Standard"
  account_replication_type = var.azurerm_storage_account.account_replication_type #"LRS"
}

resource "azurerm_sql_server" "example" {
  name                         = var.azurerm_sql_server.name #"mssqlserver"
  resource_group_name          = var.azurerm_sql_server.resource_group_name #azurerm_resource_group.example.name
  location                     = var.azurerm_sql_server.location #azurerm_resource_group.example.location
  version                      = var.azurerm_sql_server.version #"12.0"
  administrator_login          = var.azurerm_sql_server.administrator_login #"mradministrator"
  administrator_login_password = var.azurerm_sql_server.administrator_login_password #"thisIsDog11"

  tags = {
    environment = var.tags.environment
  }
}