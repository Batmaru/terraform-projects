# subnet per vnet1 

resource "azurerm_subnet" "subnet1-vnet1" {
  name                 = "subnet-vnet1"
  resource_group_name  = azurerm_resource_group.mio_gruppo_1.name
  virtual_network_name = azurerm_virtual_network.vnet1.name
  address_prefixes     = ["10.0.0.0/24"]
}

# associazione nsg1 a subnet1
resource "azurerm_subnet_network_security_group_association" "subnet1_nsg1" {
  subnet_id                 = azurerm_subnet.subnet1-vnet1.id
  network_security_group_id = azurerm_network_security_group.nsg1.id
}




# subnet per vnet2
resource "azurerm_subnet" "subnet2-vnet2" {
  name                 = "subnet-vnet2"
  resource_group_name  = azurerm_resource_group.mio_gruppo_2.name
  virtual_network_name = azurerm_virtual_network.vnet2.name
  address_prefixes     = ["10.1.1.0/24"]
}


# associazione nsg2 a subnet2
resource "azurerm_subnet_network_security_group_association" "subnet2_nsg2" {
  subnet_id                 = azurerm_subnet.subnet1-vnet2.id
  network_security_group_id = azurerm_network_security_group.nsg2.id
}