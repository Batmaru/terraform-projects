provider "azurerm" {
  features {}
  subscription_id = "3e798b21-96fa-42e9-a7a4-51186c78b650"
}
# Resource Group
resource "azurerm_resource_group" "rg" {
  name     = "rg-terraform-demo"
  location = "italynorth"
}

# Virtual Network
resource "azurerm_virtual_network" "vnet" {
  name                = "vnet-demo"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  address_space       = ["10.0.0.0/16"]
}

# Subnet
resource "azurerm_subnet" "subnet" {
  name                 = "subnet-demo"
  resource_group_name  = azurerm_resource_group.rg.name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = ["10.0.1.0/24"]
}