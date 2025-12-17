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
    description = "ID del primo gruppo di risorse"
    type        = string
  
}

variable "resource_group2_id" {
    description = "ID del secondo gruppo di risorse"
    type        = string
  
}

variable "resource_group_log_analytics_id" {
    description = "ID del gruppo di risorse per Log Analytics"
    type        = string
  
}


variable "tags" {
  description = "Tags da applicare a tutte le risorse"
  type        = map(string)
  default = {
    Project     = "progettoMihai"
    Environment = "Dev"
    Owner       = "Marwan"
  }
}



variable "enable_telemetry" {
  type        = bool
  default     = true
  description = <<DESCRIPTION
This variable controls whether or not telemetry is enabled for the module.
For more information see <https://aka.ms/avm/telemetryinfo>.
If it is set to false, then no telemetry will be collected.
DESCRIPTION
  nullable    = false
}
