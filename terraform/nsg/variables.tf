variable "tags" {
    type = object({
      environment = string
    }) 
}

variable "azurerm_network_security_group" {
    type = object({
      name                = string
      location            = string
      resource_group_name = string
      security_rule       = object({
        name                       = string
        priority                   = number
        direction                  = string
        access                     = string
        protocol                   = string
        source_port_range          = string
        destination_port_range     = number
        source_address_prefix      = string
        destination_address_prefix = string
      })
    })
}