resource "azurerm_network_security_group" "example" {
  name                = var.azurerm_network_security_group.name #"web-nsg"
  location            = var.azurerm_network_security_group.location #azurerm_resource_group.example.location
  resource_group_name = var.azurerm_network_security_group.resource_group_name #azurerm_resource_group.example.name

  security_rule {
    name                       = var.azurerm_network_security_group.security_rule.name #"allow-http"
    priority                   = var.azurerm_network_security_group.security_rule.priority #100
    direction                  = var.azurerm_network_security_group.security_rule.direction #"Inbound"
    access                     = var.azurerm_network_security_group.security_rule.access #"Allow"
    protocol                   = var.azurerm_network_security_group.security_rule.protocol #"Tcp"
    source_port_range          = var.azurerm_network_security_group.security_rule.source_port_range #"*"
    destination_port_range     = var.azurerm_network_security_group.security_rule.destination_port_range #"80"
    source_address_prefix      = var.azurerm_network_security_group.security_rule.source_address_prefix #"*"
    destination_address_prefix = var.azurerm_network_security_group.security_rule.destination_address_prefix #"*"
  }

  tags = {
    environment = var.tags.environment
  }
}