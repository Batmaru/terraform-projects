module "public_ip_bastion" {
  source  = "Azure/avm-res-network-publicipaddress/azurerm"
  version = "0.2.0"
  name                = "pip-bastion"
  location            = var.location
  resource_group_name = var.resource_group1_name

  allocation_method = "Static"
  sku               = "Standard"
}


module "bastion_vnet1" {
  source  = "Azure/avm-res-network-bastionhost/azurerm"
  version = "0.9.0"

  name                = "bastion-vnet1"
  location            = var.location
  parent_id           = var.resource_group1_id
  sku                 = "Standard"

  ip_configuration = {
    name                 = "bastion-config"
    # aggiungo false perche io public ip lho creato esternamente
    create_public_ip     = false 
    
    public_ip_address_id = module.public_ip_bastion.resource_id
    subnet_id            = module.subnet_bastion_vnet1.resource.id
  }
}