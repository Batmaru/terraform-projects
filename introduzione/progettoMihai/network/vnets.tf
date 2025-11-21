resource "azurerm_virtual_network" "vnet1" {
  name                = "vnet-1"
  location            = var.location
  resource_group_name = azurerm_resource_group.mio_gruppo_1.name
  address_space       = ["10.0.0.0/16"]
}

resource "azurerm_virtual_network" "vnet2" {
  name                = "vnet-2"
  location            = var.location
  resource_group_name = azurerm_resource_group.mio_gruppo_2.name
  address_space       = ["10.1.0.0/16"]
}


