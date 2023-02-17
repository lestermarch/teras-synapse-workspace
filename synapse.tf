resource "azurerm_synapse_role_assignment" "deployment_principal" {
  synapse_workspace_id = azurerm_synapse_workspace.synapse.id
  role_name            = "Synapse Administrator"
  principal_id         = data.azurerm_client_config.deployment.object_id

  depends_on = [
    time_sleep.firewall_delay
  ]
}

resource "azurerm_synapse_role_assignment" "synapse" {
  for_each = {
    for assignment in local.synapse_role_assignments : "${assignment.role_definition_name}.${assignment.principal_id}" => assignment
  }

  synapse_workspace_id = azurerm_synapse_workspace.synapse.id
  role_name            = each.value.role_definition_name
  principal_id         = each.value.principal_id

  depends_on = [
    time_sleep.firewall_delay
  ]
}

resource "azurerm_synapse_spark_pool" "synapse" {
  count = var.enable_spark_pool ? 1 : 0

  name                 = var.synapse_spark_pool.name
  synapse_workspace_id = azurerm_synapse_workspace.synapse.id
  node_size            = var.synapse_spark_pool.size
  node_size_family     = "MemoryOptimized"
  spark_version        = var.synapse_spark_pool.version

  auto_pause {
    delay_in_minutes = var.synapse_spark_pool.auto_pause_delay_minutes
  }

  auto_scale {
    max_node_count = var.synapse_spark_pool.max_node_count
    min_node_count = var.synapse_spark_pool.min_node_count
  }

  dynamic "library_requirement" {
    for_each = var.synapse_spark_pool.requirements != null ? [1] : []

    content {
      content  = var.synapse_spark_pool.requirements
      filename = "requirements.txt"
    }
  }

  tags = local.tags
}

resource "azurerm_synapse_sql_pool" "synapse" {
  count = var.enable_dedicated_sql_pool ? 1 : 0

  name                 = var.synapse_dedicated_sql_pool.name
  synapse_workspace_id = azurerm_synapse_workspace.synapse.id
  sku_name             = var.synapse_dedicated_sql_pool.sku
  collation            = var.synapse_dedicated_sql_pool.collation
  create_mode          = "Default"

  tags = local.tags
}

resource "azurerm_synapse_workspace" "synapse" {
  #checkov:skip=CKV_AZURE_58:  Managed virtual network may be optionally enabled
  #checkov:skip=CKV_AZURE_157: Data exfiltration protection may be optionally enabled
  #checkov:skip=CKV2_AZURE_19: Firewall is enabled with azurerm_synapse_firewall_rule
  name                                 = "synw-${var.resource_suffix}"
  resource_group_name                  = var.resource_group_name
  location                             = var.location
  data_exfiltration_protection_enabled = var.enable_data_exfiltration_protection ? true : false
  managed_resource_group_name          = "${var.resource_group_name}-synapse-managed"
  managed_virtual_network_enabled      = var.enable_private_networking ? true : false
  purview_id                           = var.purview_account_id
  storage_data_lake_gen2_filesystem_id = var.data_lake_adls_filesystem_id

  identity {
    type = "SystemAssigned"
  }

  tags = local.tags
}

resource "azurerm_synapse_workspace_aad_admin" "synapse" {
  login                = var.synapse_aad_administrator.username
  object_id            = var.synapse_aad_administrator.object_id
  synapse_workspace_id = azurerm_synapse_workspace.synapse.id
  tenant_id            = var.synapse_aad_administrator.tenant_id

  depends_on = [
    time_sleep.firewall_delay
  ]
}
