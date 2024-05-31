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
    subnet3                         = ["dummy-subnet3"]
    azurerm_resource_group_name     = "dummy-resource_group"
    azurerm_resource_group_location = "dummy-resource_group_location"
    azurerm_network_interface_id    = "dummy-azurerm_network_interface_id"
  }
}

inputs = {

  azurerm_network_security_group {
    name                = "${include.env.locals.env}web-nsg"
    location            = dependency.network.outputs.azurerm_resource_group_location
    resource_group_name = dependency.network.outputs.azurerm_resource_group_name

    security_rule {
        name                       = "allow-http"
        priority                   = 100
        direction                  = "Inbound"
        access                     = "Allow"
        protocol                   = "Tcp"
        source_port_range          = "*"
        destination_port_range     = "80"
        source_address_prefix      = "*"
        destination_address_prefix = "*"
        }
  }
  
  tags {
    environment     = "${include.env.locals.env}"
  }
  

  env = include.env.locals.env
}

terraform {
  source = "${get_parent_terragrunt_dir("root")}/..//terraform/nsg"
}