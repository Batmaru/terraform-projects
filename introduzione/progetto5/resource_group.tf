resource "azurerm_resource_group" "mio_gruppo" {
  name     = "${var.environment}-resources"
  location = "italynorth"
}