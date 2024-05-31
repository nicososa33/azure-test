resource "azurerm_resource_group" "example" {
  name     = var.azurerm_resource_group.name  
  location = var.azurerm_resource_group.location 
}

resource "azurerm_network_security_group" "example" {
  name                = var.azurerm_network_security_group.name 
  location            = azurerm_resource_group.example.location
  resource_group_name = azurerm_resource_group.example.name
}

resource "azurerm_virtual_network" "example" {
  name                = var.azurerm_virtual_network.name 
  location            = azurerm_resource_group.example.location
  resource_group_name = azurerm_resource_group.example.name
  address_space       = var.azurerm_virtual_network.address_space 
  dns_servers         = var.azurerm_virtual_network.dns_servers 

  subnet {
    name           = var.subnet1.name 
    address_prefix = var.subnet1.address_prefix 
    security_group = azurerm_network_security_group.example.id
  }

  subnet {
    name           = var.subnet2.name 
    address_prefix = var.subnet2.address_prefix 
    security_group = azurerm_network_security_group.example.id
  }

  subnet {
    name           = var.subnet3.name 
    address_prefix = var.subnet3.address_prefix 
    security_group = azurerm_network_security_group.example.id
  }

  tags = {
    environment = var.tags.environment
  }
}

resource "azurerm_public_ip" "example" {
  name                = "PublicIPForLB"
  location            = azurerm_resource_group.example.location
  resource_group_name = azurerm_resource_group.example.name
  allocation_method   = "Static"
}

resource "azurerm_lb" "lb_vm" {
  name = ""
  location = azurerm_resource_group.example.location
  resource_group_name = azurerm_resource_group.example.name

  frontend_ip_configuration {
    name                 = "PublicIPAddress"
    public_ip_address_id = azurerm_public_ip.example.id
  }
}

resource "azurerm_network_interface" "main" {
  name                = var.azurerm_network_interface.name
  location            = azurerm_resource_group.example.location
  resource_group_name = azurerm_resource_group.example.name

  ip_configuration {
    name                          = var.azurerm_network_interface.ip_configuration.name #"testconfiguration1"
    subnet_id                     = azurerm_virtual_network.example.subnet.subnet3.id
    private_ip_address_allocation = var.azurerm_network_interface.ip_configuration.private_ip_address_allocation #"Dynamic"
  }
}