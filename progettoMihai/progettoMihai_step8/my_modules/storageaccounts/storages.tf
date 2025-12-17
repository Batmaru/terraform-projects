module "naming" {
  source = "Azure/naming/azurerm"
  version = "0.4.0"

}

locals {
  nic_blob_rg1_name = "pe-blob-rg1-nic"
  nic_blob_rg2_name = "pe-blob-rg2-nic"
  nic_loganalytics_blob_name = "pe-loganalytics-blob-nic"
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
  version = "0.2.0"

  name                       = "pe-blob-rg1"
  location                   = var.location
  resource_group_name        = var.resource_group1_name
  subnet_resource_id         = var.subnet1_vnet1_id
  network_interface_name     = local.nic_blob_rg1_name

  private_connection_resource_id = module.storage_rg1.resource_id
  subresource_names              = ["blob"]
  
}


module "pe_storage_rg1_file" {
  source  = "Azure/avm-res-network-privateendpoint/azurerm"
  version = "0.2.0"

  name                       = "pe-file-rg1"
  location                   = var.location
  resource_group_name        = var.resource_group1_name
  subnet_resource_id         = var.subnet1_vnet1_id
  network_interface_name     = "pe-file-rg1-nic"

  private_connection_resource_id = module.storage_rg1.resource_id
  subresource_names              = ["file"]
}
module "dns_blob_rg1" {
  source  = "Azure/avm-res-network-privatednszone/azurerm"
  version = "0.4.3"

  domain_name = "privatelink.blob.core.windows.net"
  parent_id   = var.resource_group1_id

  virtual_network_links = {
    link_vnet1 = {
      name                 = "link-vnet1-rg1"
      virtual_network_id   = var.vnet1_rg1_id
      registration_enabled = false
    }
  }
}

resource "azurerm_private_dns_a_record" "blob_rg1_record" {
  name                = module.pe_storage_rg1_blob.resource.name
  zone_name           = module.dns_blob_rg1.resource.name
  resource_group_name = var.resource_group1_name
  ttl                 = 300

  # l'IP privato
  records = [module.pe_storage_rg1_blob.resource.private_service_connection[0].private_ip_address]
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
  version = "0.2.0"

  name                       = "pe-blob-rg2"
  location                   = var.location
  resource_group_name        = var.resource_group2_name
  subnet_resource_id         = var.subnet1_vnet2_id
  network_interface_name     = local.nic_blob_rg2_name

  private_connection_resource_id = module.storage_rg2.resource_id
  subresource_names              = ["blob"]
}

module "pe_storage_rg2_file" {
  source  = "Azure/avm-res-network-privateendpoint/azurerm"
  version = "0.2.0"

  name                       = "pe-file-rg2"
  location                   = var.location
  resource_group_name        = var.resource_group2_name
  subnet_resource_id         = var.subnet1_vnet2_id
  network_interface_name     = "pe-file-rg2-nic"

  private_connection_resource_id = module.storage_rg2.resource_id
  subresource_names              = ["file"]
}

module "dns_blob_rg2" {
  source  = "Azure/avm-res-network-privatednszone/azurerm"
  version = "0.4.3"

  domain_name = "privatelink.blob.core.windows.net"
  parent_id   = var.resource_group2_id

  virtual_network_links = {
    link_vnet1 = {
      name                 = "link-vnet1-rg2"
      virtual_network_id   = var.vnet1_rg2_id
      registration_enabled = false
    }
  }
}


resource "azurerm_private_dns_a_record" "blob_rg2_record" {
  name                = module.pe_storage_rg2_blob.resource.name
  zone_name           = module.dns_blob_rg2.resource.name
  resource_group_name = var.resource_group2_name
  ttl                 = 300

  records = [module.pe_storage_rg2_blob.resource.private_service_connection[0].private_ip_address]
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
  version = "0.2.0"

  name                = "pe-loganalytics-blob"
  location            = var.location
  resource_group_name = var.resource_group_log_analytics_name
  subnet_resource_id          = var.subnet_log_analytics_id
  network_interface_name = local.nic_loganalytics_blob_name


    private_connection_resource_id = module.storage_log_analytics.resource_id
    subresource_names              = ["blob"]
   
  
}

# PE per File
module "pe_log_analytics_file" {
  source  = "Azure/avm-res-network-privateendpoint/azurerm"
  version = "0.2.0"

  name                = "pe-loganalytics-file"
  location            = var.location
  resource_group_name = var.resource_group_log_analytics_name
  subnet_resource_id           = var.subnet_log_analytics_id
  network_interface_name = "pe-loganalytics-file"

    private_connection_resource_id = module.storage_log_analytics.resource_id
    subresource_names              = ["file"]

  
}

module "dns_blob_loganalytics" {
  source  = "Azure/avm-res-network-privatednszone/azurerm"
  version = "0.4.3"

  domain_name = "privatelink.blob.core.windows.net"
  parent_id   = var.resource_group_log_analytics_id

  virtual_network_links = {
    link_vnet_loganalytics = {
      name                 = "link-vnet-loganalytics"
      virtual_network_id   = var.vnet_log_analytics_id
      registration_enabled = false
    }
  }
}


resource "azurerm_private_dns_a_record" "blob_loganalytics_record" {
  name                = module.pe_log_analytics_blob.resource.name
  zone_name           = module.dns_blob_loganalytics.resource.name
  resource_group_name = var.resource_group_log_analytics_name
  ttl                 = 300
  
  records             = [module.pe_log_analytics_blob.resource.private_service_connection[0].private_ip_address]
}



# Hai dovuto creare tutti questi elementi (Private Endpoints e Zone DNS) proprio perché non è sufficiente "privatizzare lo storage" e basta. La privatizzazione in Azure è un processo in due fasi che richiede una specifica configurazione di rete.

# 🔒 Perché gli Storage sono Privati e Cosa Significa
# I tuoi Storage Account (storage_rg1, storage_rg2, storage_log_analytics) sono privati grazie a questa linea in ogni modulo di Storage:

# Terraform

# public_network_access_enabled = false #mettere false per privatizzarlo
# Questa impostazione blocca l'accesso pubblico a tutti i tuoi Storage Account, rendendoli inacessibili da Internet.

# 🧠 Perché Hai Avuto Bisogno di Tutte Quelle Risorse
# Per poter accedere ai dati in questi Storage Account (Blob e File) dopo aver bloccato l'accesso pubblico, devi creare un "buco" sicuro e privato nella tua rete, che è il ruolo del Private Endpoint.

# La privatizzazione in Azure si ottiene tramite la combinazione di tre elementi principali che hai implementato:

# 1. 🛑 Il Private Endpoint (PE)
# Esempio: module "pe_storage_rg1_blob"

# A Cosa Serve: Il Private Endpoint è una scheda di rete virtuale (NIC) inserita in una subnet specifica (var.subnet1_vnet1_id). Questa NIC riceve un IP privato all'interno della tua VNet.

# Come Funziona: Crea un collegamento sicuro e privato (un tunnel) tra la tua rete virtuale e l'istanza specifica del tuo servizio (il tuo Storage Account).

# Perché non Basta 1 PE: Hai dovuto creare un PE separato per ogni sottorisorsa che vuoi accedere privatamente (es. Blob, File). Per questo hai pe_storage_rg1_blob e pe_storage_rg1_file, anche se puntano allo stesso Storage Account (module.storage_rg1).

# 2. 🗺️ La Zona DNS Privata
# Esempio: module "dns_blob_rg1"

# A Cosa Serve: Quando provi ad accedere al tuo Storage Account da una VM, utilizzi ancora l'endpoint pubblico (es. storagerg1[nome_univoco].blob.core.windows.net).

# Normalmente, il DNS risolverebbe questo nome all'IP pubblico di Azure (che è bloccato).

# La Zona DNS Privata intercetta questa richiesta e, invece, risolve il nome all'IP privato assegnato al tuo Private Endpoint.

# Senza la Zona DNS: Se non avessi creato la Zona DNS, la tua VM tenterebbe di raggiungere lo Storage via Internet, l'accesso fallirebbe perché public_network_access_enabled = false, e non potresti connetterti.

# 3. 🔗 L'A Record
# Esempio: resource "azurerm_private_dns_a_record" "blob_rg1_record"

# A Cosa Serve: Questo record è il collegamento finale. Associa il nome DNS del tuo Storage (es. storagerg1[nome_univoco]) all'indirizzo IP privato che il Private Endpoint ha ottenuto nella tua subnet.

# Come Funziona: L'A Record dice alla Zona DNS: "Quando vedi una richiesta per questo nome di Storage, punta a questo indirizzo IP privato: module.pe_storage_rg1_blob.resource.private_service_connection[0].private_ip_address."

# In sintesi: "Privatizzare lo storage" (impostando public_network_access_enabled = false) spegne la porta sul lato Internet. Hai dovuto costruire tutto il resto per costruire una nuova porta (il Private Endpoint) e installare un campanello (il DNS) 
# che indichi agli utenti interni dove trovare quella nuova porta privata.