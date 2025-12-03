terraform {
  required_version = ">= 1.9.0"

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "4.53.0"
    }
  }
}


resource "azurerm_resource_group" "gruppo_log_analitics" {
  name     = "gruppo_log_analitics"
  location = "italynorth"
}


module "network" {
  source              = "../network"
  location            = var.location
  resource_group1_name = azurerm_resource_group.mio_gruppo_1.name
  resource_group2_name = azurerm_resource_group.mio_gruppo_2.name

  admin_username_vm1_rg1 = var.admin_username_vm1_rg1
  admin_password_vm1_rg1 = var.admin_password_vm1_rg1

  admin_username_vm2_rg1 = var.admin_username_vm2_rg1
  admin_password_vm2_rg1 = var.admin_password_vm2_rg1

  admin_username_vm1_rg2 = var.admin_username_vm1_rg2
  admin_password_vm1_rg2 = var.admin_password_vm1_rg2
}

module "monitoring" {
  source               = "../monitoring"
  location             = var.location
  resource_group_log_analytics_name = azurerm_resource_group.gruppo_log_analitics.name 
  resource_group_log_analytics_id = azurerm_resource_group.gruppo_log_analitics.id
  storage_account_log_analytics_id = azurerm_storage_account.storage_log_analitics.id
  vm1_rg1_id           = module.network.vnet1_vm1_id
  vm2_rg1_id           = module.network.vnet1_vm2_id
}

