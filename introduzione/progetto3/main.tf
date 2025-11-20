terraform {
  required_version = ">= 1.9.0"

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "4.53.0"
    }
  }


  backend "azurerm" {
    resource_group_name  = "mio_gruppo-resources"
    storage_account_name = "storagegroupprova123"
    container_name       = "tfstate"
    key                  = "terraform.tfstate"
  }
}

provider "azurerm" {
  features {}

  subscription_id = "3e798b21-96fa-42e9-a7a4-51186c78b650"
}

locals{
  common_tags = {
    environment = var.environment
    lob = "banking"
    stage = "alpha"
  }
}

resource "azurerm_resource_group" "mio_gruppo" {
  name     = "mio_gruppo-resources"
  location = "italynorth"
}

resource "azurerm_storage_account" "mio_storage" {
  name                     = "storagegroupprova123"
  resource_group_name      = azurerm_resource_group.mio_gruppo.name
  location                 = azurerm_resource_group.mio_gruppo.location
  account_tier             = "Standard"
  account_replication_type = "LRS"

  tags = {
    environment = local.common_tags.alpha
  }
}

resource "azurerm_storage_container" "tfstate" {
  name                  = "tfstate"
  storage_account_id  = azurerm_storage_account.mio_storage.id
  container_access_type = "private"
}

output "storage_account_name" {
  value = azurerm_storage_account.mio_storage.name
}

