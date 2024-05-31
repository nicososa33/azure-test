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


inputs = {
  azurerm_resource_group {
    name          = "${include.env.locals.env}-example-net"
    location      = "East US"
  }
  
  azurerm_network_security_group {
    name          = "${include.env.locals.env}-example-security-group"
  }

  azurerm_virtual_network {
    name          = "example-network"
    address_space = ["10.0.0.0/16"]
    dns_servers   = ["10.0.0.4", "10.0.0.5"]
  }

  subnet1 {
    name           = "subnet1"
    address_prefix = ["10.0.1.0/24"]
  }

  subnet2 {
    name           = "subnet2"
    address_prefix = ["10.0.2.0/24"]
  }

  subnet3 {
    name           = "subnet3"
    address_prefix = ["10.0.3.0/24"]
  }

  tags {
    environment     = "${include.env.locals.env}"
  }

  azurerm_network_interface {
      name                = "${include.env.locals.env}-nic"

      ip_configuration    {
        name                          = "internal"
        private_ip_address_allocation = "Dynamic"
      }
    }



  env = include.env.locals.env
}

terraform {
  source = "${get_parent_terragrunt_dir("root")}/..//terraform/network"
}