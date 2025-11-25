
#  nsg per vnet1 

resource "azurerm_network_security_group" "nsg1" {
  name                = "nsg-vnet1"
  location            = var.location
  resource_group_name = var.resource_group1_name

  security_rule {
    name                       = "AllowInbound"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "*"
    source_port_range          = "*"
    destination_port_range     = "*"
    # Solo la subnet della VNet2
    source_address_prefix      = azurerm_subnet.subnet1-vnet2.address_prefixes[0]
    destination_address_prefix = azurerm_subnet.subnet1-vnet1.address_prefixes[0]
  }


  # permettere solo traffico https in uscita
  security_rule {
  name                       = "AllowHTTPSOutbound"
  priority                   = 100
  direction                  = "Outbound"
  access                     = "Allow"
  protocol                   = "Tcp"
  source_port_range          = "*"
  destination_port_range     = "443"
  destination_address_prefix = "*"
  source_address_prefix      = "*"
}
# permettere solo traffico ssh in ingresso dal load balancer
security_rule {
  name                       = "AllowSSHFromLB"
  priority                   = 110
  direction                  = "Inbound"
  access                     = "Allow"
  protocol                   = "Tcp"
  source_port_range          = "*"
  destination_port_range     = "22"
  source_address_prefix      = azurerm_public_ip.lb_public_ip.ip_address
  destination_address_prefix = "*"
}


}





# nsg per vnet2

resource "azurerm_network_security_group" "nsg2" {
  name                = "nsg-vnet2"
  location            = var.location
  resource_group_name = var.resource_group2_name

  security_rule {
    name                       = "AllowInbound"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "*"
    source_port_range          = "*"
    destination_port_range     = "*"
    source_address_prefix      = azurerm_subnet.subnet1-vnet1.address_prefixes[0]
    destination_address_prefix = azurerm_subnet.subnet1-vnet2.address_prefixes[0]
  }

  # permettere solo traffico https in uscita
  security_rule {
  name                       = "AllowHTTPSOutbound"
  priority                   = 100
  direction                  = "Outbound"
  access                     = "Allow"
  protocol                   = "Tcp"
  source_port_range          = "*"
  destination_port_range     = "443"
  destination_address_prefix = "*"
  source_address_prefix      = "*"
}
# permettere solo traffico ssh in ingresso dal load balancer
security_rule {
  name                       = "AllowSSHFromLB"
  priority                   = 110
  direction                  = "Inbound"
  access                     = "Allow"
  protocol                   = "Tcp"
  source_port_range          = "*"
  destination_port_range     = "22"
  source_address_prefix      = azurerm_public_ip.lb_public_ip.ip_address
  destination_address_prefix = "*"
}



}