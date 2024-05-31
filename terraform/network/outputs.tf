output "azurerm_resource_group_location" {
  description = "name vnet"
  value       = azurerm_resource_group.example.location
}

output "azurerm_resource_group_name" {
  description = "value"
  value = azurerm_resource_group.example.name
}

output "vnet_address_space" {
  description = "The address space of the newly created vNet"
  value       = azurerm_virtual_network.vnet.address_space
}

output "example_id" {
  description = "The id of the newly created example"
  value       = azurerm_virtual_network.example.id
}

output "example_location" {
  description = "The location of the newly created example"
  value       = azurerm_virtual_network.example.location
}

output "example_name" {
  description = "The name of the newly created example"
  value       = azurerm_virtual_network.example.name
}


output "subnet1" {
  description = "subnet vm"
  value       = azurerm_virtual_network.example.subnet[*].id  
}

output "id" {
  description = "The publick ip ID."
  value       = azurerm_network_security_group.default.id
}

output "location" {
  description = "The location of the public IP."
  value       = azurerm_network_security_group.default.location
}

output "name" {
  description = "The name of the public IP."
  value       = azurerm_network_security_group.default.name
}

output "resource_group_name" {
  description = "The name of the resource group in which to create the public IP."
  value        = azurerm_network_security_group.default.resource_group_name
}

output "security_rule" {
  description = "The security rules of the network security group."
  value       = azurerm_network_security_group.default.security_rule
}

output "network_interface_id" {
    description = "vn id"
    value = azurerm_network_interface.main.id 
}

output "network_interface_name" {
    description = "vn name"
    value = azurerm_network_interface.main.name
}

output "private_ip_address" {
  description = "The first private IP address of the network interface."
  value       = azurerm_network_interface.main.private_ip_address
}

output "azurerm_network_interface_id" {
  description = "The ID of the Network Interface."
  value       = azurerm_network_interface.main.id
}