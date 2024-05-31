variable "azurerm_storage_account" {
    type = object({
      name                     = string
      resource_group_name      = string
      location                 = string
      account_tier             = string
      account_replication_type = string
    })
}

variable "azurerm_sql_server" {
    type = object({
      name                         = string
      resource_group_name          = string
      location                     = string
      version                      = string
      administrator_login          = string
      administrator_login_password = string 
    })
  
}

variable "tags" {
    type = object({
      environment = string
    })
  
}