include "root" {
  path   = find_in_parent_folders("terragrunt.hcl")
  expose = true
}

include "env" {
  path   = find_in_parent_folders("env.hcl")
  expose = true
}

locals {
  local_tags = {
    "name" = "net-${include.env.locals.env}-test" 
  }

  tags = merge(include.root.locals.root_tags, include.env.locals.tags, local.local_tags)
}

dependency "network" {
  config_path = "../network"
  mock_outputs = {
    example_id                      = "dummy-id"
    azurerm_resource_group_location = "dummy-location"
    subnet2                         = ["dummy-subnet2"]
    azurerm_resource_group_name     = "dummy-resource_group"
    azurerm_resource_group_location = "dummy-resource_group_location"
    azurerm_network_interface_id    = "dummy-azurerm_network_interface_id"

  }
}

inputs = {
  azurerm_storage_account {
    name                     = "examplesa"
    resource_group_name      = dependency.network.outputs.azurerm_resource_group_name
    location                 = dependency.network.outputs.azurerm_resource_group_location
    account_tier             = "Standard"
    account_replication_type = "LRS"
  }

  azurerm_sql_server {
    name                         = "${include.env.locals.env}-mssqlserver"
    resource_group_name          = dependency.network.outputs.azurerm_resource_group_name
    location                     = dependency.network.outputs.azurerm_resource_group_location
    version                      = "12.0"
    administrator_login          = "mradministrator"
    administrator_login_password = "thisIsDog11"
  }
  
  tags {
    environment     = "${include.env.locals.env}"
  }

  env = include.env.locals.env
}

terraform {
  source = "${get_parent_terragrunt_dir("root")}/..//terraform/sql"
}