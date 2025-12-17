resource "azurerm_log_analytics_workspace" "strumento_log_analitics" {
  name                = "strumentoLogAnalitics"
  location            =  var.location
  resource_group_name = var.resource_group_log_analytics_name
  sku                 = "PerGB2018"
  retention_in_days   = 30
}