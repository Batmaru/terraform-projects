
# VM1 per il primo resourceGroup1

resource "azurerm_linux_virtual_machine" "vm1_rg1" {
  name                = "vm1-rg1"
  resource_group_name = azurerm_resource_group.mio_gruppo_1.name
  location            = var.location
  size                = "Standard_B1s" 
  admin_username      = var.admin_username_vm1_rg1
  admin_password      = var.admin_password_vm1_rg1
  network_interface_ids = [module.network.nic_vnet1_vm1_id]  
  disable_password_authentication = false


  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
   publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = "22_04-lts"
    version   = "latest"
}


}



# VM1 per il primo resourceGroup2

resource "azurerm_linux_virtual_machine" "vm1_rg2" {
  name                = "vm1-rg2"
  resource_group_name = azurerm_resource_group.mio_gruppo_2.name
  location            = var.location
  size                = "Standard_B1s" 
  admin_username      = var.admin_username_vm1_rg2
  admin_password      = var.admin_password_vm1_rg2
  network_interface_ids = [
    module.network.nic_vnet2_vm1_id
  ]
  disable_password_authentication = false


  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
   publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = "22_04-lts"
    version   = "latest"
}

}


