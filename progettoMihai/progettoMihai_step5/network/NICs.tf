
# nic per vm1 
resource "azurerm_network_interface" "nic_vnet1_vm1" {
  name                = "nic-vnet1-vm1"
  location            = var.location
  resource_group_name = var.resource_group1_name
  ip_configuration {
    name                          = "ipconfig1"
    subnet_id                     = azurerm_subnet.subnet1-vnet1.id   
    private_ip_address_allocation  = "Dynamic"                  
   
  }

}

# nic per vm2
resource "azurerm_network_interface" "nic_vnet2_vm1" {
  name                = "nic-vnet2-vm1"
  location            = var.location
  resource_group_name = var.resource_group2_name

  ip_configuration {
    name                          = "ipconfig2"
    subnet_id                     = azurerm_subnet.subnet1-vnet2.id   
    private_ip_address_allocation  = "Dynamic"                  
   
  }

}
