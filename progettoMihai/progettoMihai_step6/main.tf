terraform {
  required_version = ">= 1.9.0"

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "4.53.0"
    }
  }
}

module "naming" {
  source = "Azure/naming/azurerm"
  version = "0.4.0"

}



#######################
# modulo Resourcegroups
#######################

module "resource_groups" {
  source   = "./my_modules/resourcegroups"

  location = var.location
  resource_group1_name = var.resource_group1_name
  resource_group2_name = var.resource_group2_name
  resource_group_log_analytics_name = var.resource_group_log_analytics_name
}




########################
# modulo Storageaccounts
########################

module "storage_accounts" {
  source   = "./my_modules/storageaccounts"

  location = var.location
  resource_group1_name            = module.resource_groups.resource_group1_name
  resource_group2_name            = module.resource_groups.resource_group2_name
  resource_group_log_analytics_name = module.resource_groups.resource_group_log_analytics_name
} 




########################
# module network
#######################

module "network" {
  source   = "./my_modules/network"

  location = var.location
  resource_group1_name = module.resource_groups.resource_group1_name
  resource_group2_name = module.resource_groups.resource_group2_name
  resource_group_log_analytics_name = module.resource_groups.resource_group_log_analytics_name 
  
  resource_group1_id = module.resource_groups.resource_group1_id
  resource_group2_id = module.resource_groups.resource_group2_id
  resource_group_log_analytics_id = module.resource_groups.resource_group_log_analytics_id
} 