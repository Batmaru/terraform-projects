output "resource_group1_name" {
  value = module.mio_gruppo_1.resource.name
}

output "resource_group2_name" {
  value = module.mio_gruppo_2.resource.name
}

output "resource_group_log_analytics_name" {
  value = module.gruppo_log_analitics.resource.name
}

output "resource_group1_id" {
  value = module.mio_gruppo_1.resource.id
}

output "resource_group2_id" {
  value = module.mio_gruppo_2.resource.id
}

output "resource_group_log_analytics_id" {
  value = module.gruppo_log_analitics.resource.id
}
