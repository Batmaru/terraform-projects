output "vm1_rg1_private_ip" {
  value = azurerm_network_interface.nic_vnet1_vm1.private_ip_address
}

output "vm1_rg2_private_ip" {
  value = azurerm_network_interface.nic_vnet2_vm1.private_ip_address
}


output "nic_vnet1_vm1_id" {
  value = azurerm_network_interface.nic_vnet1_vm1.id
}

output "nic_vnet2_vm1_id" {
  value = azurerm_network_interface.nic_vnet2_vm1.id
}

output "nic_vnet1_vm1_ip" {
  value = azurerm_network_interface.nic_vnet1_vm1.private_ip_address
}

output "nic_vnet2_vm1_ip" {
  value = azurerm_network_interface.nic_vnet2_vm1.private_ip_address
}


