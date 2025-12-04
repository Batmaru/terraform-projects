###############################
#  Locals per i security groups
################################

locals {
  # Security rules per NSG VNet1
  vnet1_rg1_subnet1_prefix = "10.0.0.0/24"
    vnet1_rg2_subnet1_prefix = "10.1.1.0/24"
  nsg_rules_vnet1_rg1= {
   AllowInboundFromVNet2 = {
      name                       = "AllowInboundFromVNet2"
      priority                   = 100
      direction                  = "Inbound"
      access                     = "Allow"
      protocol                   = "*"
      source_address_prefix      = local.vnet1_rg2_subnet1_prefix
      destination_address_prefix = local.vnet1_rg1_subnet1_prefix
      source_port_range          = "*"
      destination_port_range     = "*"
    }

    AllowHTTPSOutbound={
      name                       = "AllowHTTPSOutbound"
      priority                   = 110
      direction                  = "Outbound"
      access                     = "Allow"
      protocol                   = "Tcp"
      source_address_prefix      = "*"
      destination_address_prefix = "*"
      source_port_range          = "*"
      destination_port_range     = "443"
    }
    
    AllowSSHFromLB={
      name                       = "AllowSSHFromLB"
      priority                   = 120
      direction                  = "Inbound"
      access                     = "Allow"
      protocol                   = "Tcp"
      source_address_prefix      = "0.0.0.0/0"
      destination_address_prefix = "*"
      source_port_range          = "*"
      destination_port_range     = "22"
    }
  }

  # Security rules per NSG VNet2
  nsg_rules_vnet1_rg2 = {
    AllowInboundFromVNet1 = {
      name                       = "AllowInboundFromVNet1"
      priority                   = 100
      direction                  = "Inbound"
      access                     = "Allow"
      protocol                   = "*"
      source_address_prefix      = local.vnet1_rg1_subnet1_prefix
      destination_address_prefix = local.vnet1_rg2_subnet1_prefix
      source_port_range          = "*"
      destination_port_range     = "*"
    }
    AllowHTTPSOutbound = {
      name                       = "AllowHTTPSOutbound"
      priority                   = 110
      direction                  = "Outbound"
      access                     = "Allow"
      protocol                   = "Tcp"
      source_address_prefix      = "*"
      destination_address_prefix = "*"
      source_port_range          = "*"
      destination_port_range     = "443"
    }
    AllowSSHFromLB = {
      name                       = "AllowSSHFromLB"
      priority                   = 120
      direction                  = "Inbound"
      access                     = "Allow"
      protocol                   = "Tcp"
      source_address_prefix      = "0.0.0.0/0"
      destination_address_prefix = "*"
      source_port_range          = "*"
      destination_port_range     = "22"
    }
}
}

###############################
# Modulo NSG VNet1 rg1
###############################
module "nsg_vnet1_rg1" {
  source  = "Azure/avm-res-network-networksecuritygroup/azurerm"
  version = "0.5.0"

  name                = "nsg-vnet1"
  location            = var.location
  resource_group_name = var.resource_group1_name

  security_rules       = local.nsg_rules_vnet1_rg1
}

###############################
# Modulo NSG VNet1 rg2
###############################
module "nsg_vnet1_rg2" {
  source  = "Azure/avm-res-network-networksecuritygroup/azurerm"
  version = "0.5.0"

  name                = "nsg-vnet2"
  location            = var.location
  resource_group_name = var.resource_group2_name

  security_rules      = local.nsg_rules_vnet1_rg2
}


################################
# NSG Log Analytics
################################

locals {
  vnet_log_analytics_prefix = "10.2.0.0/24"

  nsg_rules_log_analytics = {
    AllowInboundFromVNet1 = {
      name                       = "AllowInboundFromVNet1"
      priority                   = 100
      direction                  = "Inbound"
      access                     = "Allow"
      protocol                   = "*"
      source_address_prefix      = "10.0.0.0/16"  # VNet1 address space completo
      destination_address_prefix = local.vnet_log_analytics_prefix
      source_port_range          = "*"
      destination_port_range     = "*"
    }

    AllowInboundFromVNet2 = {
      name                       = "AllowInboundFromVNet2"
      priority                   = 110
      direction                  = "Inbound"
      access                     = "Allow"
      protocol                   = "*"
      source_address_prefix      = "10.1.0.0/16"  # VNet2 address space completo
      destination_address_prefix = local.vnet_log_analytics_prefix
      source_port_range          = "*"
      destination_port_range     = "*"
    }

    AllowHTTPSOutbound = {
      name                       = "AllowHTTPSOutbound"
      priority                   = 120
      direction                  = "Outbound"
      access                     = "Allow"
      protocol                   = "Tcp"
      source_address_prefix      = "*"
      destination_address_prefix = "*"
      source_port_range          = "*"
      destination_port_range     = "443"
    }
  }
}

###############################
# Modulo NSG Log Analytics
###############################
module "nsg_log_analytics" {
  source  = "Azure/avm-res-network-networksecuritygroup/azurerm"
  version = "0.5.0"

  name                = "nsg-loganalytics"
  location            = var.location
  resource_group_name = var.resource_group_log_analytics_name

  security_rules      = local.nsg_rules_log_analytics
}


