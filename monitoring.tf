data "azurerm_log_analytics_workspace" "monitoring_workspace" {
  count = var.enable_monitoring ? 1 : 0

  name                = var.log_analytics_workspace_name
  resource_group_name = var.log_analytics_resource_group_name
}

resource "azurerm_monitor_diagnostic_setting" "synapse" {
  count = var.enable_monitoring ? 1 : 0

  name                       = "SynapseMetrics"
  target_resource_id         = azurerm_synapse_workspace.synapse.id
  log_analytics_workspace_id = data.azurerm_log_analytics_workspace.monitoring_workspace[0].id

  dynamic "metric" {
    for_each = toset(var.synapse_monitoring_metrics)

    content {
      category = each.key
      enabled  = true

      retention_policy {
        days    = 0
        enabled = false
      }
    }
  }

  dynamic "log" {
    for_each = toset(var.synapse_monitoring_logs)

    content {
      category = each.key
      enabled  = true

      retention_policy {
        days    = 0
        enabled = false
      }
    }
  }
}

resource "azurerm_monitor_diagnostic_setting" "synapse_dedicated_sql_pool" {
  count = var.enable_monitoring && var.enable_dedicated_sql_pool ? 1 : 0

  name                       = "SynapseDedicatedSqlPool"
  target_resource_id         = azurerm_synapse_sql_pool.synapse[0].id
  log_analytics_workspace_id = data.azurerm_log_analytics_workspace.monitoring_workspace[0].id

  dynamic "metric" {
    for_each = toset(var.synapse_dedicated_sql_pool_monitoring_metrics)

    content {
      category = each.key
      enabled  = true

      retention_policy {
        days    = 0
        enabled = false
      }
    }
  }

  dynamic "log" {
    for_each = toset(var.synapse_dedicated_sql_pool_monitoring_logs)

    content {
      category = each.key
      enabled  = true

      retention_policy {
        days    = 0
        enabled = false
      }
    }
  }
}

resource "azurerm_monitor_diagnostic_setting" "synapse_spark_pool" {
  count = var.enable_monitoring && var.enable_spark_pool ? 1 : 0

  name                       = "SynapseSparkPool"
  target_resource_id         = azurerm_synapse_sql_pool.synapse[0].id
  log_analytics_workspace_id = data.azurerm_log_analytics_workspace.monitoring_workspace[0].id

  dynamic "metric" {
    for_each = toset(var.synapse_spark_pool_monitoring_metrics)

    content {
      category = each.key
      enabled  = true

      retention_policy {
        days    = 0
        enabled = false
      }
    }
  }

  dynamic "log" {
    for_each = toset(var.synapse_spark_pool_monitoring_logs)

    content {
      category = each.key
      enabled  = true

      retention_policy {
        days    = 0
        enabled = false
      }
    }
  }
}
