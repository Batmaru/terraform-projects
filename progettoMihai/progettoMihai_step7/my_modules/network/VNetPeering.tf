module "vnet1_to_vnet2" {
  source  = "Azure/avm-res-network-virtualnetwork/azurerm//modules/peering"
  version = "0.16.0"

  name                       = "vnet1-to-vnet2"
  parent_id                  = module.vnet1_rg1.resource.id
  remote_virtual_network_id  = module.vnet1_rg2.resource.id

  allow_forwarded_traffic    = true
  allow_gateway_transit      = false
  allow_virtual_network_access = true
  create_reverse_peering               = true
  use_remote_gateways                  = false

  reverse_name                         = "vnet2-to-vnet1"
  reverse_allow_forwarded_traffic      = true
  reverse_allow_gateway_transit        = false
  reverse_allow_virtual_network_access = true
  reverse_use_remote_gateways          = false
}
