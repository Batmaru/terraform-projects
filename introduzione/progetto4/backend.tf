  terraform{ 
    backend "azurerm" {
    resource_group_name  = "mio_gruppo-resources"
    storage_account_name = "storagegroupprova123"
    container_name       = "tfstate"
    key                  = "terraform.tfstate"
  }
  }
