
# Creazione di un indirizzo IP pubblico per il load balancer
resource "azurerm_public_ip" "lb_public_ip" {
  name                = "publicip-lb"
  location            = var.location
  resource_group_name = var.resource_group1_name
  allocation_method   = "Static"
  sku                 = "Standard"
}

# Load Balancer pubblico di tipo Standard
resource "azurerm_lb" "public_lb" {
  name                = "lb-public-standard"
  location            = var.location
  resource_group_name = var.resource_group1_name
  sku                 = "Standard"

  frontend_ip_configuration {
    name                 = "PublicFrontEnd"
    public_ip_address_id = azurerm_public_ip.lb_public_ip.id
  }
}

# Backend address pool per il load balancer
resource "azurerm_lb_backend_address_pool" "lb_backend_pool" {
  name            = "BackendPool"
  loadbalancer_id = azurerm_lb.public_lb.id
}

resource "azurerm_lb_nat_rule" "ssh_nat1" {
  name                           = "SSH-Linux1"
  loadbalancer_id                = azurerm_lb.public_lb.id
  resource_group_name = var.resource_group1_name
  protocol                       = "Tcp"
  frontend_port                  = 43434
  backend_port                   = 22
  frontend_ip_configuration_name = "PublicFrontEnd"
}

resource "azurerm_lb_nat_rule" "ssh_nat2" {
  name                           = "SSH-Linux2"
  loadbalancer_id                = azurerm_lb.public_lb.id
  resource_group_name = var.resource_group1_name
  protocol                       = "Tcp"
  frontend_port                  = 43436
  backend_port                   = 22
  frontend_ip_configuration_name = "PublicFrontEnd"
}

# resource "azurerm_lb_nat_rule" "rdp_nat" {
#   name                           = "RDP-Windows"
#   resource_group_name = var.resource_group1_name
#   loadbalancer_id                = azurerm_lb.public_lb.id
#   protocol                       = "Tcp"
#   frontend_port                  = 43435
#   backend_port                   = 3389
#   frontend_ip_configuration_name = "PublicFrontEnd"
# }

resource "azurerm_network_interface_nat_rule_association" "linux_ssh_assoc_nic_vnet1_vm1" {
  network_interface_id  = azurerm_network_interface.nic_vnet1_vm1.id
  ip_configuration_name = "ipconfig1"
  nat_rule_id           = azurerm_lb_nat_rule.ssh_nat1.id
}

resource "azurerm_network_interface_nat_rule_association" "linux_ssh_assoc_nic_vnet2_vm1" {
  network_interface_id  = azurerm_network_interface.nic_vnet2_vm1.id
  ip_configuration_name = "ipconfig2"
  nat_rule_id           = azurerm_lb_nat_rule.ssh_nat2.id
}
