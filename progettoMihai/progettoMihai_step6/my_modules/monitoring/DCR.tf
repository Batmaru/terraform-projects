

#Un User Assigned Identity è un tipo di Managed Identity in Azure.

#È un’identità gestita da Azure, che puoi assegnare a risorse come VM, App Service, Funzioni, o anche a una Data Collection Rule (DCR).

#Serve a far sì che la risorsa possa autenticarsi su altre risorse Azure senza usare username/password o segreti.

# non obbligatorio

resource "azurerm_user_assigned_identity" "UAI" {
  name                = "uai"
  resource_group_name = var.resource_group_log_analytics_name
  location            = var.location
}

# Log Analytics Solution WindowsEventForwarding:
# Installa una soluzione preconfezionata che raccoglie Event Log di Windows
# e li invia al Log Analytics Workspace.
# essendo per windows e usando io una vm windows la commenterò

# resource "azurerm_log_analytics_solution" "example" {
#   solution_name         = "WindowsEventForwarding"
#   location              = azurerm_resource_group.example.location
#   resource_group_name   = azurerm_resource_group.example.name
#   workspace_resource_id = azurerm_log_analytics_workspace.example.id
#   workspace_name        = azurerm_log_analytics_workspace.example.name
#   plan {
#     publisher = "Microsoft"
#     product   = "OMSGallery/WindowsEventForwarding"
#   }
# }


#Namespace = contenitore logico per uno o più Event Hub (come una cartella per i topic/eventi).

#Serve a raccolta e distribuzione di eventi: puoi inviare log, metriche o dati da diverse fonti e farli leggere da più servizi

resource "azurerm_eventhub_namespace" "eventhub_namespace1" {
  name                = "eventhubnamespace12345876387fijdhuf"
  location            = var.location
  resource_group_name = var.resource_group_log_analytics_name
  sku                 = "Standard"
  capacity            = 1
}

resource "azurerm_eventhub" "eventhub1" {
  name                = "eventhub1"
  namespace_id     = azurerm_eventhub_namespace.eventhub_namespace1.id

  partition_count     = 2 # numero di partizioni per l'evento hub
  message_retention   = 1 # giorni in cui i messaggi vengono conservati
}


# container per lo storage account del log analitycs
resource "azurerm_storage_container" "container1" {
  name                  = "containerlog"
  storage_account_id  = var.storage_account_log_analytics_id
  container_access_type = "private"
}



# DCE = punto centrale di raccolta dei dati dalle tue risorse (VM, container, applicazioni).

# Funziona come “gateway” sicuro che riceve i dati di log/metriche prima di inviarli alle destinazioni (Log Analytics, Event Hub, Storage).

# Ti permette di centralizzare la raccolta dei dati e applicare regole di sicurezza, routing e trasformazioni.
resource "azurerm_monitor_data_collection_endpoint" "DCE1" {
  name                = "DCE"
  resource_group_name = var.resource_group_log_analytics_name
  location            = var.location

  lifecycle {
    create_before_destroy = true
  }
}

resource "azurerm_monitor_data_collection_rule" "DCR1" {
  name                        = "DCR"
  resource_group_name = var.resource_group_log_analytics_name
  location            = var.location
  data_collection_endpoint_id = azurerm_monitor_data_collection_endpoint.DCE1.id

  destinations {
  log_analytics {
    workspace_resource_id = azurerm_log_analytics_workspace.strumento_log_analitics.id
    name                  = "destination-log-analitics"
  }



    event_hub {
      event_hub_id = azurerm_eventhub.eventhub1.id
      name         = "example-destination-eventhub"
    }

    storage_blob {
      storage_account_id = var.storage_account_log_analytics_id
      container_name     = azurerm_storage_container.container1.name
      name               = "example-destination-storage"
    }

    azure_monitor_metrics {
      name = "destination-metrics"
    }
  }


  # Data flow
  # Un data flow in una Data Collection Rule (DCR) di Azure Monitor è fondamentalmente una regola che instrada i dati 
  # raccolti da una o più data sources verso una o più destinazioni.

  data_flow {
    streams      = ["Microsoft-InsightsMetrics"]
    destinations = ["destination-metrics"]
  }

  data_flow {
    streams      = ["Microsoft-InsightsMetrics", "Microsoft-Syslog", "Microsoft-Perf"]
    destinations = ["destination-log-analitics"]
  }

  data_flow {
    streams       = ["Custom-MyTableRawData"]
    destinations  = ["destination-log-analitics"]
    output_stream = "Microsoft-Syslog"
    transform_kql = "source | project TimeGenerated = Time, Computer, Message = AdditionalContext"
  }

  # Data sources per Linux
  data_sources {
    syslog {
      facility_names = ["*"]
      log_levels     = ["*"]
      name           = "linux-syslog"
      streams        = ["Microsoft-Syslog"]
    }

    # iis_log {
    #   streams         = ["Microsoft-W3CIISLog"]
    #   name            = "example-datasource-iis"
    #   log_directories = ["C:\\Logs\\W3SVC1"]
    # }

    # log_file {
    #   name          = "example-datasource-logfile"
    #   format        = "text"
    #   streams       = ["Custom-MyTableRawData"]
    #   file_patterns = ["C:\\JavaLogs\\*.log"]
    #   settings {
    #     text {
    #       record_start_timestamp_format = "ISO 8601"
    #     }
    #   }
    # }

    performance_counter {
      streams                       = ["Microsoft-Perf", "Microsoft-InsightsMetrics"]
      sampling_frequency_in_seconds = 60
      counter_specifiers            = ["Processor(*)\\% Processor Time"]
      name                          = "lonux-performance-counter"
    }

    # windows_event_log {
    #   streams        = ["Microsoft-WindowsEvent"]
    #   x_path_queries = ["*![System/Level=1]"]
    #   name           = "example-datasource-wineventlog"
    # }

    # extension {
    #   streams            = ["Microsoft-WindowsEvent"]
    #   input_data_sources = ["example-datasource-wineventlog"]
    #   extension_name     = "example-extension-name"
    #   extension_json = jsonencode({
    #     a = 1
    #     b = "hello"
    #   })
    #   name = "example-datasource-extension"
    # }
  }

  stream_declaration {
    stream_name = "Custom-MyTableRawData"
    column {
      name = "Time"
      type = "datetime"
    }
    column {
      name = "Computer"
      type = "string"
    }
    column {
      name = "AdditionalContext"
      type = "string"
    }
  }

  identity {
    type         = "UserAssigned"
    identity_ids = [azurerm_user_assigned_identity.UAI.id]
  }

  description = "Data Collection Rule completa, pronta per Linux e future integrazioni"
  tags = {
    environment = "staging"
  }
#   depends_on = [
#     azurerm_log_analytics_solution.example
#   ]
 }

 # Associazione DCR alla VM1 Linux
resource "azurerm_monitor_data_collection_rule_association" "dcra1" {
  name                    = "dcra1"
  target_resource_id      = var.vm1_rg1_id
  data_collection_rule_id = azurerm_monitor_data_collection_rule.DCR1.id
  description             = "associazione DCR a VM Linux"
}

# Associazione DCE alla VM1 Linux non piu funzionante
# resource "azurerm_monitor_data_collection_endpoint_association" "dcea1" {
#   target_resource_id          = azurerm_linux_virtual_machine.vm1_rg1.id
#   data_collection_endpoint_id = azurerm_monitor_data_collection_endpoint.DCE1.id
#   description                 = "associazione DCE a VM Linux"
# }

# Associazione DCR alla VM2 Linux 
resource "azurerm_monitor_data_collection_rule_association" "dcra2" {
  name                    = "dcra2"
  target_resource_id      = var.vm2_rg1_id
  data_collection_rule_id = azurerm_monitor_data_collection_rule.DCR1.id
  description             = "associazione DCR a VM Linux"
}

# # Associazione DCE alla VM2 Linux (non piu funzionante)
# resource "azurerm_monitor_data_collection_endpoint_association" "dcea2" {
#   target_resource_id          = azurerm_linux_virtual_machine.vm1_rg2.id
#   data_collection_endpoint_id = azurerm_monitor_data_collection_endpoint.DCE1.id
#   description                 = "associazione DCE a VM Linux"
# }