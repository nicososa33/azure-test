variable "azurerm_virtual_machine" {
    type = object({
      count                 = number
      name                  = string
      location              = string
      resource_group_name   = string
      network_interface_ids = list(string)
      vm_size = string
      storage_image_reference = object({
        publisher = string
        offer     = string
        sku       = string
        version   = string
      })
      storage_os_disk = object({
        name              = string
        caching           = string
        create_option     = string
        managed_disk_type = string
      })
    })
}

variable "azurerm_virtual_machine_app" {
    type = object({
      name                  = string
      location              = string
      resource_group_name   = string
      network_interface_ids = list(string)
      vm_size = string
      storage_image_reference = object({
        publisher = string
        offer     = string
        sku       = string
        version   = string
      })
      storage_os_disk = object({
        name              = string
        caching           = string
        create_option     = string
        managed_disk_type = string
      })
    })  
}

variable "tags" {
    type = object({
      environment = string
    })
  
}