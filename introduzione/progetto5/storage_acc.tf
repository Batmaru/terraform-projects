resource "azurerm_storage_account" "mio_storage" {
  name                     = "storagegroupprova123"
  resource_group_name      = azurerm_resource_group.mio_gruppo.name
  location                 = azurerm_resource_group.mio_gruppo.location
  account_tier             = "Standard"
  account_replication_type = "LRS"

  tags = {
    environment = local.common_tags.environment
  }
}