output "vm1_vnet1_id" {
    value = module.vm1_vnet1_rg1.resource_id
}

output "vm2_vnet1_id" {
    value = module.vm2_vnet1_rg1.resource_id
}


output "public_ip_bastion"{
    value = module.public_ip_bastion.resource_id
}

output "subnet1_vnet1_id"{
    value = module.subnet1_vnet1.resource_id
}

output "vnet1_rg1_id"{
    value = module.vnet1_rg1.resource_id
}
output "vnet1_rg2_id"{
    value= module.vnet1_rg2.resource_id
}
output "subnet1_vnet2_id"{
    value = module.subnet1_vnet2.resource_id
}

output "subnet_log_analytics_id"{
    value = module.subnet_log_analytics.resource_id
}

output "vnet_log_analytics_id"{
    value = module.vnet_log_analytics.resource_id
}