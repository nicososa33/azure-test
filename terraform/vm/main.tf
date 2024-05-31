resource "azurerm_virtual_machine" "web" {
  count                 = var.azurerm_virtual_machine.count #2
  name                  = "${var.azurerm_virtual_machine.name}-vm-${count.index}"
  location              = var.azurerm_virtual_machine.location 
  resource_group_name   = var.azurerm_virtual_machine.resource_group_name
  network_interface_ids = var.azurerm_virtual_machine.network_interface_ids
  vm_size               = var.azurerm_virtual_machine.vm_size 


  storage_image_reference {
    publisher = var.azurerm_virtual_machine.storage_image_reference.publisher
    offer     = var.azurerm_virtual_machine.storage_image_reference.offer
    sku       = var.azurerm_virtual_machine.storage_image_reference.sku 
    version   = var.azurerm_virtual_machine.storage_image_reference.version
  }
  storage_os_disk {
    name              = var.azurerm_virtual_machine.storage_os_disk.name 
    caching           = var.azurerm_virtual_machine.storage_os_disk.caching 
    create_option     = var.azurerm_virtual_machine.storage_os_disk.create_option
    managed_disk_type = var.azurerm_virtual_machine.storage_os_disk.managed_disk_type
  }
  os_profile {
    computer_name  = "hostname-${count.index}"
    admin_username = "testadmin"
    admin_password = "Password1234!"
  }
  os_profile_linux_config {
    disable_password_authentication = false
  }
  tags = {
    environment = var.tags.environment
  }
}

############################
####        app         ####
############################

resource "azurerm_virtual_machine" "app" {
  count = 2
  name                  = var.azurerm_virtual_machine_app.name
  location              = var.azurerm_virtual_machine_app.location 
  resource_group_name   = var.azurerm_virtual_machine_app.resource_group_name
  network_interface_ids = var.azurerm_virtual_machine_app.network_interface_ids
  vm_size               = var.azurerm_virtual_machine_app.vm_size 


  storage_image_reference {
    publisher = var.azurerm_virtual_machine_app.storage_image_reference.publisher
    offer     = var.azurerm_virtual_machine_app.storage_image_reference.offer
    sku       = var.azurerm_virtual_machine_app.storage_image_reference.sku 
    version   = var.azurerm_virtual_machine_app.storage_image_reference.version
  }
  storage_os_disk {
    name              = var.azurerm_virtual_machine_app.storage_os_disk.name 
    caching           = var.azurerm_virtual_machine_app.storage_os_disk.caching 
    create_option     = var.azurerm_virtual_machine_app.storage_os_disk.create_option
    managed_disk_type = var.azurerm_virtual_machine_app.storage_os_disk.managed_disk_type
  }
  os_profile {
    computer_name  = "hostname"
    admin_username = "testadmin"
    admin_password = "Password1234!"
  }
  os_profile_linux_config {
    disable_password_authentication = false
  }
  tags = {
    environment = "dev"
  }
}
