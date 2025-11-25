
#PRIVATE DNS ZONE (che funziona solo dentro Azure, con le due VNet)

resource "azurerm_private_dns_zone" "DNS1_zone" {
  name                = "progettoMihai.com"
  resource_group_name = var.resource_group1_name
}

