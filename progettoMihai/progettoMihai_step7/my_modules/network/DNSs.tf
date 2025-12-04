locals {
  private_link_private_dns_zones_final = {
    "progettoMihai" = {
      zone_name = "progettoMihai.com"
      virtual_network_links = {
        "vnet1_rg1_link" = {
          virtual_network_id    = module.vnet1_rg1.resource.id
          name                  = "link-vnet1-rg1"
          registration_enabled  = true
          resolution_policy     = "Default"
        }
        "vnet1_rg2_link" = {
          virtual_network_id    = module.vnet1_rg2.resource.id
          name                  = "link-vnet1-rg2"
          registration_enabled  = false
          resolution_policy     = "Default"
        }
      }
    }
  }
}

module "DNS1_zone" {
  source  = "Azure/avm-res-network-privatednszone/azurerm"
  version = "0.4.3"
  for_each = local.private_link_private_dns_zones_final

  domain_name           = each.value.zone_name
  parent_id             = var.resource_group1_id
  virtual_network_links = each.value.virtual_network_links
  enable_telemetry      = var.enable_telemetry
  tags                  = var.tags
}
