output "vm1_rg1_private_ip" {
  value = module.network.nic_vnet1_vm1_ip
}

output "vm1_rg2_private_ip" {
  value = module.network.nic_vnet2_vm1_ip
}
