variable "environment" {
  type = string
}


variable "storage_disk"{
  type =number
  description = "the storage disk size of os"
  default = 80
}

variable "is_delete" {
  type = bool
  description = "whether to delete the os disk when deleting the vm"
  default = true
}