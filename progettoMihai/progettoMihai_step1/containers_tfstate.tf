# Container TF state RG1
resource "azurerm_storage_container" "tfstate_rg1" {
  name                  = "tfstate"
  storage_account_id = azurerm_storage_account.storage1_rg1.id
  container_access_type = "private"
}

# Container TF state RG2
resource "azurerm_storage_container" "tfstate_rg2" {
  name                  = "tfstate"
  storage_account_id  = azurerm_storage_account.storage1_rg2.id
  container_access_type = "private"
}
