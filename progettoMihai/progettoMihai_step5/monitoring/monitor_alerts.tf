
resource "azurerm_monitor_action_group" "actiongroup1" {
  name                = "actiongroup1"
  resource_group_name = azurerm_resource_group.gruppo_log_analitics.name
  short_name          = "ag1"

  email_receiver {
    name          = "email marwan"
    email_address = "marwanrafik02@gmail.com"
  }

  sms_receiver {
    name         = "messaggio_alert"
    country_code = "39"
    phone_number = "3889816796"
  }
}
    

  resource "azurerm_monitor_metric_alert" "cpu_alert" {
  name                = "cpu-alert-test"
  resource_group_name = azurerm_resource_group.mio_gruppo_1.name
  description         = "Test alert - scatta quando la CPU è > 1%"
  severity            = 2
  frequency           = "PT5M"
  window_size         = "PT30M"
  auto_mitigate       = true

  scopes = [
    azurerm_linux_virtual_machine.vm1_rg1.id
  ]

  criteria {
    metric_namespace = "Microsoft.Compute/virtualMachines"
    metric_name      = "Percentage CPU"
    aggregation      = "Average"
    operator         = "GreaterThan"
    threshold        = 1
  }

  action {
    action_group_id = azurerm_monitor_action_group.actiongroup1.id
  }
}
