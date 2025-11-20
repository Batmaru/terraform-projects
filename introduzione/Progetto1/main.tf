terraform{
    required_providers {
      azurerm = {
        source = "hashicorp/azurerm"
        version = "4.53.0"
      }
    }
    required_version = ">=1.9.0"
    
}
resource "azurerm_resource_group" "mio_gruppo" {
  name     = "mio_gruppo-resources"
  location = "italynorth"
}

provider "azurerm" {
    features {

    }
    subscription_id = "3e798b21-96fa-42e9-a7a4-51186c78b650"

}

resource "azurerm_storage_account" "mio_gruppo" {
  name                     = "storagegroupprova123"
  resource_group_name      = azurerm_resource_group.mio_gruppo.name
  location                 = azurerm_resource_group.mio_gruppo.location  #implicit dependency
  account_tier             = "Standard"
  account_replication_type = "LRS"

  tags = {
    environment = "staging"
  }
}


#tf init, tf plan , tf apply