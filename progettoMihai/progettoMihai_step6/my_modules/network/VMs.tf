locals {
  # VM1 RG1
  admin_username_vm1_rg1 = "localadmin1"
  admin_password_vm1_rg1 = "PasswordSicura123!"

  # VM2 RG1
  admin_username_vm2_rg1 = "localadmin2"
  admin_password_vm2_rg1 = "PasswordSicura123!"
}

module "naming" {
  source = "Azure/naming/azurerm"
  version = "0.4.0"

}

module "vm1_vnet1_rg1" {
  source  = "Azure/avm-res-compute-virtualmachine/azurerm"
  version = "0.20.0"
  
  name                = "vm1-rg1${module.naming.virtual_machine.name_unique}"
  resource_group_name = var.resource_group1_name
  location            = var.location
  admin_username       = local.admin_username_vm1_rg1
  admin_password      = local.admin_password_vm1_rg1
  zone                = "1"
    os_type             = "Linux" 
  network_interfaces = {
  nic1 = {
    name          = "nic1-vm1"
    
    
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



module "vm2_vne1_rg1" {
  source  = "Azure/avm-res-compute-virtualmachine/azurerm"
  version = "0.20.0"
  
  name                = "vm2-rg1${module.naming.virtual_machine.name_unique}"
  resource_group_name = var.resource_group1_name
  location            = var.location
  admin_username       = local.admin_username_vm2_rg1
  admin_password      = local.admin_password_vm2_rg1
  zone                = "1"
    os_type             = "Linux" 
    

  network_interfaces = {
  nic2 = {
    name          = "nic1-vm2"
    
    
    ip_configurations = {
    ipconfig1 = {
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
