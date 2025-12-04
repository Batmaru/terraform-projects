module "naming" {
  source = "Azure/naming/azurerm"
  version = "0.4.0"

}

# Storage Account RG1 usando AVM
module "storage_rg1" {
  source  = "Azure/avm-res-storage-storageaccount/azurerm"
  version = "0.6.7"

  name                ="storagerg1${module.naming.storage_account.name_unique}"

  location            = var.location
  resource_group_name = var.resource_group1_name

  account_kind              = "StorageV2"
  account_tier              = "Standard"
  account_replication_type  = "LRS"
  public_network_access_enabled = false #mettere false per privatizzarlo
  shared_access_key_enabled     = true

  tags = {
    environment = "staging"
  }
}

module "pe_storage_rg1_blob" {
  source  = "Azure/avm-res-network-privateendpoint/azurerm"
  version = "0.6.0"

  name                = "pe-blob-rg1"
  location            = var.location
  resource_group_name = var.resource_group1_name
  subnet_id           = module.subnet1_vnet1.resource.id

  private_service_connection = {
    name                           = "pe-blob-rg1-connection"
    private_connection_resource_id = module.storage_rg1.resource_id

    subresource_names              = ["blob"]
    is_manual_connection           = false
  }
}


module "pe_storage_rg1_file" {
  source  = "Azure/avm-res-network-privateendpoint/azurerm"
  version = "0.6.0"

  name                = "pe-file-rg1"
  location            = var.location
  resource_group_name = var.resource_group1_name
  subnet_id           = module.subnet1_vnet1.resource.id

  private_service_connection = {
    name                           = "pe-file-rg1-connection"
    private_connection_resource_id = module.storage_rg1.resource_id
    subresource_names              = ["file"]
    is_manual_connection           = false
  }
}
module "dns_blob_rg1" {
  source  = "Azure/avm-res-network-privatednszone/azurerm"
  version = "0.4.3"

  domain_name = "privatelink.blob.core.windows.net"
  parent_id   = var.resource_group1_id

  virtual_network_links = {
    link_vnet1 = {
      name                 = "link-vnet1-rg1"
      virtual_network_id   = module.vnet1_rg1.resource.id
      registration_enabled = false
    }
  }
}

resource "azurerm_private_dns_a_record" "blob_rg1_record" {
  name                = module.pe_storage_rg1_blob.resource.name
  zone_name           = module.dns_blob_rg1.resource.domain_name
  resource_group_name = var.resource_group1_name
  ttl                 = 300
  records             = module.pe_storage_rg1_blob.private_ip_addresses
}


# Storage Account RG2 usando AVM
module "storage_rg2" {
  source  = "Azure/avm-res-storage-storageaccount/azurerm"
  version = "0.6.7"

  name                = "storage1rg2${module.naming.storage_account.name_unique}"
  location            = var.location
  resource_group_name = var.resource_group2_name

  account_kind              = "StorageV2"
  account_tier              = "Standard"
  account_replication_type  = "LRS"
  public_network_access_enabled = false
  shared_access_key_enabled     = true

  tags = {
    environment = "staging"
  }
}


module "pe_storage_rg2_blob" {
  source  = "Azure/avm-res-network-privateendpoint/azurerm"
  version = "0.6.0"

  name                = "pe-blob-rg2"
  location            = var.location
  resource_group_name = var.resource_group2_name
  subnet_id           = module.subnet1_vnet2.resource.id

  private_service_connection = {
    name                           = "pe-blob-rg2-connection"
    private_connection_resource_id = module.storage_rg2.resource_id
    
    subresource_names              = ["blob"]
    is_manual_connection           = false
  }
}


module "pe_storage_rg2_file" {
  source  = "Azure/avm-res-network-privateendpoint/azurerm"
  version = "0.6.0"

  name                = "pe-file-rg2"
  location            = var.location
  resource_group_name = var.resource_group2_name
  subnet_id           = module.subnet1_vnet2.resource.id

  private_service_connection = {
    name                           = "pe-file-rg2-connection"
    private_connection_resource_id = module.storage_rg2.resource_id
    subresource_names              = ["file"]
    is_manual_connection           = false
  }
}
module "dns_blob_rg2" {
  source  = "Azure/avm-res-network-privatednszone/azurerm"
  version = "0.4.3"

  domain_name = "privatelink.blob.core.windows.net"
  parent_id   = var.resource_group2_id

  virtual_network_links = {
    link_vnet1 = {
      name                 = "link-vnet1-rg2"
      virtual_network_id   = module.vnet1_rg2.resource.id
      registration_enabled = false
    }
  }
}

resource "azurerm_private_dns_a_record" "blob_rg2_record" {
  name                = module.pe_storage_rg2_blob.resource.name
  zone_name           = module.dns_blob_rg2.resource.domain_name
  resource_group_name = var.resource_group2_name
  ttl                 = 300
  records             = module.pe_storage_rg2_blob.private_ip_addresses
}



# Storage Account Log Analytics usando AVM
module "storage_log_analytics" {
  source  = "Azure/avm-res-storage-storageaccount/azurerm"
  version = "0.6.7"

  name                = "storagelog${module.naming.storage_account.name_unique}"
  location            = var.location
  resource_group_name = var.resource_group_log_analytics_name

  account_kind              = "StorageV2"
  account_tier              = "Standard"
  account_replication_type  = "LRS"
  public_network_access_enabled = false
  shared_access_key_enabled     = true

  tags = {
    environment = "staging"
  }
}


# PE per Blob
module "pe_log_analytics_blob" {
  source  = "Azure/avm-res-network-privateendpoint/azurerm"
  version = "0.6.0"

  name                = "pe-loganalytics-blob"
  location            = var.location
  resource_group_name = var.resource_group_log_analytics_name
  subnet_id           = module.subnet_log_analytics.resource.id

  private_service_connection = {
    name                           = "pe-loganalytics-blob-connection"
    private_connection_resource_id = module.storage_log_analytics.resource_id
    subresource_names              = ["blob"]
    is_manual_connection           = false
  }
}

# PE per File
module "pe_log_analytics_file" {
  source  = "Azure/avm-res-network-privateendpoint/azurerm"
  version = "0.6.0"

  name                = "pe-loganalytics-file"
  location            = var.location
  resource_group_name = var.resource_group_log_analytics_name
  subnet_id           = module.subnet_log_analytics.resource.id

  private_service_connection = {
    name                           = "pe-loganalytics-file-connection"
    private_connection_resource_id = module.storage_log_analytics.resource_id
    subresource_names              = ["file"]
    is_manual_connection           = false
  }
}

module "dns_blob_loganalytics" {
  source  = "Azure/avm-res-network-privatednszone/azurerm"
  version = "0.4.3"

  domain_name = "privatelink.blob.core.windows.net"
  parent_id   = var.resource_group_log_analytics_id

  virtual_network_links = {
    link_vnet_loganalytics = {
      name                 = "link-vnet-loganalytics"
      virtual_network_id   = module.vnet_log_analytics.resource.id
      registration_enabled = false
    }
  }
}

resource "azurerm_private_dns_a_record" "blob_loganalytics_record" {
  name                = module.pe_log_analytics_blob.resource.name
  zone_name           = module.dns_blob_loganalytics.resource.domain_name
  resource_group_name = var.resource_group_log_analytics_name
  ttl                 = 300
  records             = module.pe_log_analytics_blob.private_ip_addresses
}
