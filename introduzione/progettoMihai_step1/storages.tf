# Random integer per RG1
resource "random_integer" "random1" {
  min = 1000
  max = 9999
}

# Storage Account RG1
resource "azurerm_storage_account" "storage1_rg1" {
  name                     = "storage1rg1${random_integer.random1.result}"
  resource_group_name      = azurerm_resource_group.mio_gruppo_1.name
  location                 = var.location
  account_tier             = "Standard"
  account_replication_type = "LRS"

  tags = {
    environment = "staging"
  }
}

# Random integer per RG2
resource "random_integer" "random2" {
  min = 1000
  max = 9999
}

# Storage Account RG1
resource "azurerm_storage_account" "storage1_rg2" {
  name                     = "storage1rg2${random_integer.random2.result}"
  resource_group_name      = azurerm_resource_group.mio_gruppo_2.name
  location                 = var.location
  account_tier             = "Standard"
  account_replication_type = "LRS"

  tags = {
    environment = "staging"
  }
}