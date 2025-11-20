terraform {
  required_version = ">= 1.9.0"

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "4.53.0"
    }
  }
}

resource "azurerm_resource_group" "mio_gruppo" {
  name     = "mio_gruppo-resources"
  location = "italynorth"
}



