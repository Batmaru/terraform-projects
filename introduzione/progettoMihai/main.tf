terraform {
  required_version = ">= 1.9.0"

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "4.53.0"
    }
  }
}




module "network" {
  source              = "./network"
  location            = var.location
  resource_group1_name = azurerm_resource_group.mio_gruppo_1.name
  resource_group2_name = azurerm_resource_group.mio_gruppo_2.name
}
