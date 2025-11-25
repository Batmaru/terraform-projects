resource "azurerm_private_dns_zone_virtual_network_link" "link_vnet1" {
  name                  = "link-vnet1"
  resource_group_name   = var.resource_group1_name
  private_dns_zone_name = azurerm_private_dns_zone.DNS1_zone.name
  virtual_network_id    = azurerm_virtual_network.vnet1.id
  registration_enabled  = true 
}

resource "azurerm_private_dns_zone_virtual_network_link" "link_vnet2" {
  name                  = "link-vnet2"
  resource_group_name   = var.resource_group1_name
  private_dns_zone_name = azurerm_private_dns_zone.DNS1_zone.name
  virtual_network_id    = azurerm_virtual_network.vnet2.id
  registration_enabled  = true
}
