module "mio_gruppo_1" {
  source  = "Azure/avm-res-resources-resourcegroup/azurerm"
  version = "0.2.1"

  name     = var.resource_group1_name
  location = var.location
}

module "mio_gruppo_2" {
  source  = "Azure/avm-res-resources-resourcegroup/azurerm"
  version = "0.2.1"

  name     = var.resource_group2_name
  location = var.location
}

module "gruppo_log_analitics" {
  source  = "Azure/avm-res-resources-resourcegroup/azurerm"
  version = "0.2.1"

  name     =  var.resource_group_log_analytics_name
  location = var.location
}
