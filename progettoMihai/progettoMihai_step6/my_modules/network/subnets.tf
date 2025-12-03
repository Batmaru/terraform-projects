###############################
# Subnet per VNet1
###############################
module "subnet1_vnet1" {
  source  = "Azure/avm-res-network-virtualnetwork/azurerm//modules/subnet"
  version = "0.16.0"

  name                 = "subnet1-vnet1_rg1"
  parent_id            = module.vnet1_rg1.resource.id          # ID della VNet1 rg1
  address_prefixes     = ["10.0.0.0/24"]
}
  # associa NSG se il modulo lo supporta
  
  resource "azurerm_subnet_network_security_group_association" "subnet1_vnet1_nsg1_association" {
  subnet_id                 = module.subnet1_vnet1.resource.id
  network_security_group_id = module.nsg_vnet1_rg1.resource.id
}

###############################
# Subnet per VNet2
###############################
module "subnet1_vnet2" {
  source  = "Azure/avm-res-network-virtualnetwork/azurerm//modules/subnet"
  version = "0.16.0"

  name                 = "subnet1-vnet1_rg2"
  parent_id            = module.vnet1_rg2.resource.id          # ID della VNet1 rg 2
  address_prefixes     = ["10.1.1.0/24"]
}
  # associa NSG se il modulo lo supporta
 
# Associazione NSG VNet2 → subnet2
resource "azurerm_subnet_network_security_group_association" "subnet1_vnet1_nsg2_association" {
  subnet_id                 = module.subnet1_vnet2.resource.id
  network_security_group_id = module.nsg_vnet1_rg2.resource.id
}

