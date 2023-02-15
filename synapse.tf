resource "azurerm_synapse_workspace" "synapse" {
  #checkov:skip=CKV_AZURE_58:  Managed virtual network may be optionally enabled
  #checkov:skip=CKV_AZURE_157: Data exfiltration protection may be optionally enabled
  #checkov:skip=CKV2_AZURE_19: Firewall is enabled with azurerm_synapse_firewall_rule
  name                                 = "synw-${var.resource_suffix}"
  resource_group_name                  = var.resource_group_name
  location                             = data.azurerm_resource_group.deployment_group.location
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
