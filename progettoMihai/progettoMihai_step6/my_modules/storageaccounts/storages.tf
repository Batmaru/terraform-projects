module "naming" {
  source = "Azure/naming/azurerm"
  version = "0.4.0"

}

# Storage Account RG1 usando AVM
module "storage_rg1" {
  source  = "Azure/avm-res-storage-storageaccount/azurerm"
  version = "0.6.7"

  name                ="storagerg1${module.naming.storage_account.name_unique}"

  location            = var.location
  resource_group_name = var.resource_group1_name

  account_kind              = "StorageV2"
  account_tier              = "Standard"
  account_replication_type  = "LRS"
  public_network_access_enabled = true
  shared_access_key_enabled     = true

  tags = {
    environment = "staging"
  }
}


# Storage Account RG2 usando AVM
module "storage_rg2" {
  source  = "Azure/avm-res-storage-storageaccount/azurerm"
  version = "0.6.7"

  name                = "storage1rg2${module.naming.storage_account.name_unique}"
  location            = var.location
  resource_group_name = var.resource_group2_name

  account_kind              = "StorageV2"
  account_tier              = "Standard"
  account_replication_type  = "LRS"
  public_network_access_enabled = true
  shared_access_key_enabled     = true

  tags = {
    environment = "staging"
  }
}



# Storage Account Log Analytics usando AVM
module "storage_log_analytics" {
  source  = "Azure/avm-res-storage-storageaccount/azurerm"
  version = "0.6.7"

  name                = "storagelog${module.naming.storage_account.name_unique}"
  location            = var.location
  resource_group_name = var.resource_group_log_analytics_name

  account_kind              = "StorageV2"
  account_tier              = "Standard"
  account_replication_type  = "LRS"
  public_network_access_enabled = true
  shared_access_key_enabled     = true

  tags = {
    environment = "staging"
  }
}
