
# VM1 per il primo resourceGroup1

resource "azurerm_linux_virtual_machine" "vm1_rg1" {
  name                = "vm1-rg1"
  resource_group_name = var.resource_group1_name
  location            = var.location
  size                = "Standard_B1s" 
  admin_username      = var.admin_username_vm1_rg1
  admin_password      = var.admin_password_vm1_rg1
  network_interface_ids = [azurerm_network_interface.nic_vnet1_vm1.id]  
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

# VM2 per il primo resourceGroup1

resource "azurerm_linux_virtual_machine" "vm2_rg1" {
  name                = "vm2-rg1"
  resource_group_name = var.resource_group1_name
  location            = var.location
  size                = "Standard_B1s" 
  admin_username      = var.admin_username_vm2_rg1
  admin_password      = var.admin_password_vm2_rg1
  network_interface_ids = [
    azurerm_network_interface.nic_vnet1_vm2.id
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







# VM1 per il primo resourceGroup2

resource "azurerm_linux_virtual_machine" "vm1_rg2" {
  name                = "vm1-rg2"
  resource_group_name = var.resource_group2_name
  location            = var.location
  size                = "Standard_B1s" 
  admin_username      = var.admin_username_vm1_rg2
  admin_password      = var.admin_password_vm1_rg2
  network_interface_ids = [
    azurerm_network_interface.nic_vnet2_vm1.id
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


