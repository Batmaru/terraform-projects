resource "azurerm_log_analytics_workspace" "strumento_log_analitics" {
  name                = "strumentoLogAnalitics"
  location            = azurerm_resource_group.gruppo_log_analitics.location
  resource_group_name = azurerm_resource_group.gruppo_log_analitics.name
  sku                 = "PerGB2018"
  retention_in_days   = 30
}