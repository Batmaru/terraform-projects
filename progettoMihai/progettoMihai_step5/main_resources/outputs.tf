#output per gli IP privati delle  nic delle VM
output "vm1_rg1_private_ip" {
  value = module.network.nic_vnet1_vm1_ip
}

output "vm1_rg2_private_ip" {
  value = module.network.nic_vnet2_vm1_ip
}


# output per i nomi dei resource group creati
output "mio_gruppo_1_name" {
  value = azurerm_resource_group.mio_gruppo_1.name
}

output "mio_gruppo_2_name" {
  value = azurerm_resource_group.mio_gruppo_2.name
}


#
output " resource_group_log_analytics_name" {
  value = azurerm_resource_group.gruppo_log_analitics.name
}
#  output per il nome del resource group del log analitics
output "gruppo_log_analitics_name" {
  value = azurerm_resource_group.gruppo_log_analitics.name


}
