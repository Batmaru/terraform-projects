variable "location" {
  description = "La location delle risorse Azure"
  type        = string
}


variable "admin_username_vm1" {
  description = "Nome utente amministratore della VM"
  type        = string
}

variable "admin_password_vm1" {
  description = "Password dell'amministratore della VM"
  type        = string
  sensitive   = true
}


