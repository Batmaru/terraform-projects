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




variable "public_ip_bastion"{
    type = string
}

variable "subnet1_vnet1_id"{
    type =string
}

variable "vnet1_rg1_id"{
    type = string
}
variable "vnet1_rg2_id"{
    type=string
}
variable "subnet1_vnet2_id"{
    type = string
}

variable "subnet_log_analytics_id"{
    type= string
}

variable "vnet_log_analytics_id"{
    type = string
}