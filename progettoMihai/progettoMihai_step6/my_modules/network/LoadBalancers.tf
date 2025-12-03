module "lb_public_ip" {
    source  = "Azure/avm-res-network-publicipaddress/azurerm"
    version = "0.2.0"
    name                = "publicip-lb"
    location            = var.location
    resource_group_name = var.resource_group1_name

    sku                 = "Standard"
    allocation_method   = "Static"
}



module "public_lb" {
  source  = "Azure/avm-res-network-loadbalancer/azurerm"
  version = "0.4.1"

  name                = "lb-public-standard"
  location            = var.location
  resource_group_name = var.resource_group1_name
  sku                 = "Standard"

  # Frontend IP
  frontend_ip_configurations = {
    public = {
      name                 = "PublicFrontEnd"
      public_ip_address_id = module.lb_public_ip.resource_id
    }
  }

 
  
}
# Backend pool
resource "azurerm_lb_backend_address_pool" "vm_backend_pool" {
  name            = "BackendPool"
  loadbalancer_id = module.public_lb.resource_id  # output del modulo AVM
  
}

# NAT rule VM1
resource "azurerm_lb_nat_rule" "ssh_vm1" {
  name                           = "SSH-VM1"
  loadbalancer_id                = module.public_lb.resource_id
  resource_group_name            = var.resource_group1_name
  protocol                       = "Tcp"
  frontend_port                  = 43434
  backend_port                   = 22
  frontend_ip_configuration_name = "PublicFrontEnd"
}

# NAT rule VM2
resource "azurerm_lb_nat_rule" "ssh_vm2" {
  name                           = "SSH-VM2"
  loadbalancer_id                = module.public_lb.resource_id
  resource_group_name            = var.resource_group1_name
  protocol                       = "Tcp"
  frontend_port                  = 43436
  backend_port                   = 22
  frontend_ip_configuration_name = "PublicFrontEnd"
}
