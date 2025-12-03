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
    public_ip_address_name = "public_lb_public_ip_1"
    create_public_ip_address = true
  }
  }
}

 
  

# Backend pool
resource "azurerm_lb_backend_address_pool" "vm_backend_pool" {
  name            = "BackendPool"
  loadbalancer_id = module.public_lb.resource_id  # output del modulo AVM
  
}

# NAT rule VM1
resource "azurerm_lb_nat_rule" "ssh_nat_vm1" {
  name                           = "SSH-VM1"
  loadbalancer_id                = module.public_lb.resource_id
  resource_group_name            = var.resource_group1_name
  protocol                       = "Tcp"
  frontend_port                  = 43434
  backend_port                   = 22
  frontend_ip_configuration_name = "PublicFrontEnd"
}

# NAT rule VM2
resource "azurerm_lb_nat_rule" "ssh_nat_vm2" {
  name                           = "SSH-VM2"
  loadbalancer_id                = module.public_lb.resource_id
  resource_group_name            = var.resource_group1_name
  protocol                       = "Tcp"
  frontend_port                  = 43436
  backend_port                   = 22
  frontend_ip_configuration_name = "PublicFrontEnd"
}


# VM1 - Backend pool
resource "azurerm_network_interface_backend_address_pool_association" "vm1_backend" {
  network_interface_id    = module.vm1_vnet1_rg1.network_interfaces["nic1"].id
  ip_configuration_name   = "ipconfig1"
  backend_address_pool_id = azurerm_lb_backend_address_pool.vm_backend_pool.id

}

# VM2 - Backend pool
resource "azurerm_network_interface_backend_address_pool_association" "vm2_backend" {
  network_interface_id    = module.vm2_vnet1_rg1.network_interfaces["nic2"].id
  ip_configuration_name   = "ipconfig2"
  backend_address_pool_id = azurerm_lb_backend_address_pool.vm_backend_pool.id

}

# VM1 - NAT rule SSH
resource "azurerm_network_interface_nat_rule_association" "vm1_ssh_nat" {
  network_interface_id  = module.vm1_vnet1_rg1.network_interfaces["nic1"].id
  ip_configuration_name = "ipconfig1"
  nat_rule_id           = azurerm_lb_nat_rule.ssh_nat_vm1.id
}

# VM2 - NAT rule SSH
resource "azurerm_network_interface_nat_rule_association" "vm2_ssh_nat" {
  network_interface_id  = module.vm2_vnet1_rg1.network_interfaces["nic2"].id
  ip_configuration_name = "ipconfig2"
  nat_rule_id           = azurerm_lb_nat_rule.ssh_nat_vm2.id
}
