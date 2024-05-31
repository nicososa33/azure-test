variable "azurerm_resource_group" {
    type = object({
      name = string
      location = string
    })
}

variable "azurerm_network_security_group" {
    type = object({
      name = string
    })
}

variable "azurerm_virtual_network" {
    type = object({
      name = string
      address_space = list(string)
      dns_servers = list(string)
    })  
}

variable "subnet1" {
    type = object({
      name = string
      address_prefix = list(string)
    })
}

variable "subnet2" {
    type = object({
      name = string
      address_prefix = list(string)
    })
}

variable "subnet3" {
    type = object({
      name = string
      address_prefix = list(string)
    })
}

variable "tags" {
    type = object({
      environment = string
    })
  
}

variable "azurerm_network_interface" {
    type = object({
      name                = string
      ip_configuration    = object({
        name                          = string
        private_ip_address_allocation = string
      })
    })   
}