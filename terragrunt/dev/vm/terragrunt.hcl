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
  azurerm_virtual_machine {
    count                 = 2
    name                  = "web-test"
    location              = dependency.network.outputs.azurerm_resource_group_location
    resource_group_name   = dependency.network.outputs.azurerm_resource_group_name
    network_interface_ids = [dependency.network.outputs.azurerm_network_interface_id]
    vm_size               = "Standard_DS1_v2"

    storage_image_reference {
        publisher = "Canonical"
        offer     = "0001-com-ubuntu-server-jammy"
        sku       = "22_04-lts"
        version   = "latest"
    }

    storage_os_disk {
        name              = "myosdisk1"
        caching           = "ReadWrite"
        create_option     = "FromImage"
        managed_disk_type = "Standard_LRS"
    }

  }
  azurerm_virtual_machine_app {
    name                  = "${include.env.locals.env}-app_test"
    location              = dependency.network.outputs.azurerm_resource_group_location
    resource_group_name   = dependency.network.outputs.azurerm_resource_group_name
    network_interface_ids = [dependency.network.outputs.azurerm_network_interface_id]
    vm_size               = "Standard_DS1_v2"

    storage_image_reference {
        publisher = "Canonical"
        offer     = "0001-com-ubuntu-server-jammy"
        sku       = "22_04-lts"
        version   = "latest"
    }

    storage_os_disk {
        name              = "myosdisk1"
        caching           = "ReadWrite"
        create_option     = "FromImage"
        managed_disk_type = "Standard_LRS"
    }

  }
  tags {
    environment     = "${include.env.locals.env}"
  }
  

  env = include.env.locals.env
}

terraform {
  source = "${get_parent_terragrunt_dir("root")}/..//terraform/vm"
}