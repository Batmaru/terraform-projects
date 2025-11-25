resource "azurerm_virtual_network" "VNet1" {
  name                = "${var.environment}-network"
  address_space       = ["10.0.0.0/16"]
  location            = azurerm_resource_group.mio_gruppo.location
  resource_group_name = azurerm_resource_group.mio_gruppo.name
}

resource "azurerm_subnet" "subnet1_VNet1" {
  name                 = "internal"
  resource_group_name  = azurerm_resource_group.mio_gruppo.name
  virtual_network_name = azurerm_virtual_network.VNet1.name
  address_prefixes     = ["10.0.2.0/24"]
}

resource "azurerm_network_interface" "NIC1" {
  name                = "${var.environment}-nic"
  location            = azurerm_resource_group.mio_gruppo.location
  resource_group_name = azurerm_resource_group.mio_gruppo.name

  ip_configuration {
    name                          = "testconfiguration1"
    subnet_id                     = azurerm_subnet.subnet1_VNet1.id
    private_ip_address_allocation = "Dynamic"
  }
}
