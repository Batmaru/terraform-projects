
# nic per vm1 
resource "azurerm_network_interface" "nic_vnet1_vm1" {
  name                = "nic-vnet1-vm1"
  location            = var.location
  resource_group_name = azurerm_resource_group.mio_gruppo_1.name

  ip_configuration {
    name                          = "ipconfig1"
    subnet_id                     = azurerm_subnet.subnet1-vnet1.id   
    private_ip_address_allocation  = "Dynamic"                  
   
  }

}

# nic per vm2
resource "azurerm_network_interface" "nic_vnet2_vm2" {
  name                = "nic-vnet2-vm2"
  location            = var.location
  resource_group_name = azurerm_resource_group.mio_gruppo_2.name

  ip_configuration {
    name                          = "ipconfig2"
    subnet_id                     = azurerm_subnet.subnet2-vnet2.id   
    private_ip_address_allocation  = "Dynamic"                  
   
  }

}
