variable "location" {

    description = "La location delle risorse Azure"
    type        = string
  
}
variable "resource_group1_name" {
    description = "Nome del primo gruppo di risorse"
    type        = string
}
variable "resource_group2_name" {
    description = "Nome del secondo gruppo di risorse"
    type        = string
}
variable "resource_group_log_analytics_name" {
    description = "Location del primo gruppo di risorse"
    type        = string
}

variable "resource_group1_id" {
    description = "Id del primo gruppo di risorse"
    type        = string
}

variable "resource_group2_id" {
    description = "Id del secondo gruppo di risorse"
    type        = string
}

variable "resource_group_log_analytics_id" {
    description = "Id del gruppo di risorse log analytics"
    type = string
}