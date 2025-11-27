# Locations

variable "location" {
  description = "La location delle risorse Azure"
  type        = string
}




variable "resource_group1_name" {
  description = "Nome del primo Resource Group"
  type        = string
}

variable "resource_group2_name" {
  description = "Nome del secondo Resource Group"
  type        = string
}




# Credenziali della VM1 nel primo resource group

variable "admin_username_vm1_rg1" {
  description = "Nome utente amministratore della VM"
  type        = string
}

variable "admin_password_vm1_rg1" {
  description = "Password dell'amministratore della VM"
  type        = string
  sensitive   = true
}

# Credenziali della VM2 nel primo resource group
variable "admin_username_vm2_rg1" {
  description = "Nome utente amministratore della VM"
  type        = string
}

variable "admin_password_vm2_rg1" {
  description = "Password dell'amministratore della VM"
  type        = string
  sensitive   = true
}



# Credenziali della VM2 nel secondo resource group

variable "admin_username_vm1_rg2" {
  description = "Nome utente amministratore della VM"
  type        = string
}

variable "admin_password_vm1_rg2" {
  description = "Password dell'amministratore della VM"
  type        = string
  sensitive   = true
}

