resource "azurerm_windows_virtual_machine" "vm1" {
  name                = "vm1"
  resource_group_name = azurerm_resource_group.mio_gruppo_1.name
  location            = var.location
  size                = "Standard_B1s" 
  admin_username      = var.admin_username_vm1
  admin_password      = var.admin_password_vm1
  network_interface_ids = [
    azurerm_network_interface.nic1.id
  ]

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
  publisher = "MicrosoftWindowsDesktop"
  offer     = "windows-11"
  sku       = "win11-22h2-pro"  
  version   = "latest"
}

}
