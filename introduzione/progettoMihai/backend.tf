# terraform {
#   backend "azurerm" {
#     resource_group_name  = "mio_gruppo_1"
#     storage_account_name = "storage1rg1xxxx"   # il nome reale dopo apply
#     container_name       = "tfstate"
#     key                  = "terraform.tfstate"
#   }
# }
