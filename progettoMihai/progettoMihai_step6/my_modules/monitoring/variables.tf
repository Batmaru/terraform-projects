variable "location" {
  description = "La location delle risorse Azure"
    type        = string
}

variable "resource_group_log_analytics_id" {
  description = "Nome del Resource Group per il Log Analytics"
  type        = string
}

variable "storage_account_log_analytics_id" {
  description = "Nome dello Storage Account per il Log Analytics"
  type        = string
}

variable "vm1_rg1_id" {
  description = "ID della VM1 nel primo resource group"
  type        = string
}

variable "vm2_rg1_id" {
    description = "ID della VM2 nel primo resource group"
    type        = string
  
}

variable "resource_group_log_analytics_name" {
    description = "nome del group_log_analytcs"
}

variable "mio_gruppo1_name"{
  description = " nome del mio_gruppo_1"
}

