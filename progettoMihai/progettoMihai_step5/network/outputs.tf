# output per gli IP privati delle VM

output "vm1_rg1_private_ip" {
  value = azurerm_network_interface.nic_vnet1_vm1.private_ip_address
}

output "vm1_rg2_private_ip" {
  value = azurerm_network_interface.nic_vnet2_vm1.private_ip_address
}

output "vm2_rg1_private_ip" {
  
  value = azurerm_network_interface.nic_vnet1_vm2.private_ip_address
}


# iyutput per le NIC delle VM

output "nic_vnet1_vm1_id" {
  value = azurerm_network_interface.nic_vnet1_vm1.id
}
output "nic_vnet1_vm2_id" {
  value = azurerm_network_interface.nic_vnet1_vm2.id
}

output "nic_vnet2_vm1_id" {
  value = azurerm_network_interface.nic_vnet2_vm1.id

}
# output per gli IP privati delle NIC delle VM
output "nic_vnet1_vm1_ip" {
  value = azurerm_network_interface.nic_vnet1_vm1.private_ip_address
}

output "nic_vnet2_vm1_ip" {
  value = azurerm_network_interface.nic_vnet2_vm1.private_ip_address
}
output "nic_vnet1_vm2_ip" {
  value = azurerm_network_interface.nic_vnet2_vm1.private_ip_address
}




# output per l'IP pubblico del load balancer
output "lb_public_ip_address" {
  value = azurerm_public_ip.lb_public_ip.ip_address
}


# output per gli ID delle VM
output "vnet1_vm1_id"{
  value = azurerm_linux_virtual_machine.vm1_rg1.id
}
output "vnet1_vm2_id"{
  value = azurerm_linux_virtual_machine.vm2_rg1.id
}