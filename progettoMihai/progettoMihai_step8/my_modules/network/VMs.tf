locals {
  # VM1 RG1
  admin_username_vm1_rg1 = "azureuser"


  # VM2 RG1
  admin_username_vm2_rg1 = "azureuser"
  
}
# Qui implemento la parte delle key
# Genera le coppie di chiavi SSH RSA 4096-bit, (crea sia la chiave privata che pubblica)
resource "tls_private_key" "ssh_key_vm1" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "tls_private_key" "ssh_key_vm2" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

# Key Vault Dedicato alle VM (Nel RG1), serve per salvare le chiavi in sicurezza
resource "azurerm_key_vault" "vm_keys" {
  name                       = "kv-vm-keys-${module.naming.key_vault.name_unique}"
  location                   = var.location
  resource_group_name        = var.resource_group1_name #
  tenant_id                  = data.azurerm_client_config.current.tenant_id
  sku_name                   = "standard"

  # Protezione obbligatoria per prevenire la perdita permanente dei segreti
  purge_protection_enabled   = true
  soft_delete_retention_days = 7
  
  # Aggiungere qui la policy di accesso (esempio):
  access_policy {
    tenant_id = data.azurerm_client_config.current.tenant_id
    object_id = data.azurerm_client_config.current.object_id # ID dell'utente/Service Principal che esegue Terraform
  # Permessi per gestire i segreti (chiavi SSH)
  # Permessi:
    # "Get": Leggere il segreto (per recuperare la chiave e fare SSH)
    # "List": Vedere quali segreti sono presenti nel KV
    # "Set": Caricare/Aggiornare il segreto (necessario per Terraform)
    # "Delete": Rimuovere il segreto
    secret_permissions = [
      "Get",
      "List",
      "Set",
      "Delete"
    ]
  }
  
  # Policy per un gruppo che può accedere alle chiavi delle VM.
  # access_policy {
  #   tenant_id = data.azurerm_client_config.current.tenant_id
  #   object_id = azurerm_azuread_group.vm_admins.object_id # ID del Gruppo AAD 

  #   secret_permissions = [ "Get", "List" ]
  # }
}



# Salvataggio Chiave Privata VM1 nel key vault
resource "azurerm_key_vault_secret" "vm1_private_key" {
  name         = "vm1-ssh-key-priv"
  value        = tls_private_key.ssh_key_vm1.private_key_pem # Chiave Privata VM1
  key_vault_id = azurerm_key_vault.vm_keys.id
  content_type = "text/plain"
}

# Salvataggio Chiave Privata VM2 nel key vault
resource "azurerm_key_vault_secret" "vm2_private_key" {
  name         = "vm2-ssh-key-priv"
  value        = tls_private_key.ssh_key_vm2.private_key_pem # Chiave Privata VM2
  key_vault_id = azurerm_key_vault.vm_keys.id
  content_type = "text/plain"
}


# configurazion e azure client, per recuperare dinamicamente l'identita del utente , il tenant etc:
data "azurerm_client_config" "current" {}



module "naming" {
  source = "Azure/naming/azurerm"
  version = "0.4.0"

}
# creazion delle vm

module "vm1_vnet1_rg1" {
  source  = "Azure/avm-res-compute-virtualmachine/azurerm"
  version = "0.20.0"
  
  name                = "vm1-rg1${module.naming.virtual_machine.name_unique}"
  resource_group_name = var.resource_group1_name
  location            = var.location
  disable_password_authentication = true
  admin_ssh_keys = [
  {
    username   = local.admin_username_vm1_rg1
    public_key = tls_private_key.ssh_key_vm1.public_key_openssh
  }
  
]
# INIEZIONE CLOUD-INIT: per crea gli utenti 'localadmin'
  custom_data = base64encode(
    templatefile("${path.module}/cloud-init-setup.yaml", {
      desired_username = "localadmin1" 
      ssh_public_key   = tls_private_key.ssh_key_vm1.public_key_openssh
      
    })
  )

  zone                = "1"
    os_type             = "Linux" 
  network_interfaces = {
  nic1 = {
    name          = "nic-vm1"
    
    network_security_group_id = module.nsg_vnet1_rg1.resource.id

    
    ip_configurations = {
    ipconfig1 = {
    name = "ipconfig1"
    private_ip_subnet_resource_id               = module.subnet1_vnet1.resource.id


    private_ip_address_allocation = "Dynamic"
    # public_ip_address_id = module.public_ip_vm1.id   # opzionale
  }
}

  }
}

  os_disk = {
  caching              = "ReadWrite"
  storage_account_type = "Standard_LRS"
  disk_size_gb         = 128   # dimensione del disco in GB

}


  source_image_reference = {
   publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = "22_04-lts"
    version   = "latest"
}
}



module "vm2_vnet1_rg1" {
  source  = "Azure/avm-res-compute-virtualmachine/azurerm"
  version = "0.20.0"
  
  name                = "vm2-rg1${module.naming.virtual_machine.name_unique}"
  resource_group_name = var.resource_group1_name
  location            = var.location
  disable_password_authentication = true
  admin_ssh_keys = [
  {
    username   = local.admin_username_vm2_rg1
    public_key = tls_private_key.ssh_key_vm2.public_key_openssh
  }
]
#  INIEZIONE CLOUD-INIT
  custom_data = base64encode(
    templatefile("${path.module}/cloud-init-setup.yaml", {
     desired_username = "localadmin2"
      ssh_public_key   = tls_private_key.ssh_key_vm2.public_key_openssh

    
    })
  )

  zone                = "1"
    os_type             = "Linux" 
    

  network_interfaces = {
  nic2 = {
    name          = "nic-vm2"
    network_security_group_id = module.nsg_vnet1_rg1.resource.id

    
    
    ip_configurations = {
    ipconfig2 = {
        name = "ipconfig2"
        private_ip_subnet_resource_id        = module.subnet1_vnet1.resource.id


    private_ip_address_allocation = "Dynamic"
    # public_ip_address_id = module.public_ip_vm1.id   # opzionale
  }
}

  }
}

  os_disk = {
  caching              = "ReadWrite"
  storage_account_type = "Standard_LRS"
  disk_size_gb         = 128   # dimensione del disco in GB

}


  source_image_reference = {
   publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = "22_04-lts"
    version   = "latest"
}
}
