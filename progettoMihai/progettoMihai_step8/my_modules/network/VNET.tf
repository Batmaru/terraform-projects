module "vnet1_rg1" {
  source  = "Azure/avm-res-network-virtualnetwork/azurerm"
  version = "0.16.0"
  # insert the 2 required variables here

  name                = "vnet1_rg1"
  location            = var.location
  parent_id           = var.resource_group1_id
  address_space       = ["10.0.0.0/16"]
}

module "vnet1_rg2" {
  source  = "Azure/avm-res-network-virtualnetwork/azurerm"
  version = "0.16.0"
  # insert the 2 required variables here

  name                = "vnet1_rg2"
  location            = var.location
  parent_id           = var.resource_group2_id
  address_space       = ["10.1.0.0/16"]
}

# VNet per Log Analytics
module "vnet_log_analytics" {
  source    = "Azure/avm-res-network-virtualnetwork/azurerm"
  version   = "0.16.0"
  name      = "vnet-loganalytics"
  location  = var.location
  parent_id = var.resource_group_log_analytics_id
  address_space = ["10.2.0.0/16"]
}



