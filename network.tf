data "azurerm_storage_account" "data_lake" {
  name                = var.data_lake_account_name
  resource_group_name = var.data_lake_resource_group_name
}

data "azurerm_virtual_network" "vnet" {
  count = var.enable_private_networking ? 1 : 0

  name                = var.vnet_name
  resource_group_name = var.vnet_resource_group_name
}

resource "azurerm_private_endpoint" "synapse" {
  for_each = {
    for endpoint, config in local.synapse_private_endpoints :
    endpoint => config if contains(local.synapse_private_endpoints_to_create, endpoint)
  }

  name                = each.value.endpoint_name
  resource_group_name = var.resource_group_name
  location            = data.azurerm_virtual_network.vnet[0].location
  subnet_id           = "${data.azurerm_virtual_network.vnet[0].id}/subnets/${var.synapse_private_endpoint_subnet_name}"

  private_dns_zone_group {
    name                 = "SynapsePrivateDnsZone"
    private_dns_zone_ids = var.synapse_private_dns_zone_ids
  }

  private_service_connection {
    name                           = each.key
    is_manual_connection           = false
    private_connection_resource_id = each.value.target_resource_id
    subresource_names              = each.value.subresource_names
  }

  depends_on = [
    azurerm_synapse_private_link_hub.synapse
  ]

  tags = local.tags
}

resource "azurerm_synapse_firewall_rule" "allow_all_azure" {
  name                 = "AllowAllWindowsAzureIps"
  synapse_workspace_id = azurerm_synapse_workspace.synapse.id
  start_ip_address     = "0.0.0.0"
  end_ip_address       = "0.0.0.0"
}

resource "azurerm_synapse_firewall_rule" "allow_all" {
  count = length(local.firewall_allowed_ip_addresses) == 0 ? 1 : 0

  name                 = "AllowAll"
  synapse_workspace_id = azurerm_synapse_workspace.synapse.id
  start_ip_address     = "0.0.0.0"
  end_ip_address       = "255.255.255.255"
}

resource "azurerm_synapse_firewall_rule" "allowed_ips" {
  for_each = toset(local.firewall_allowed_ip_addresses)

  name                 = format("AllowRule%02s", index(local.firewall_allowed_ip_addresses, each.value) + 1)
  synapse_workspace_id = azurerm_synapse_workspace.synapse.id
  start_ip_address     = cidrhost(each.value, 0)
  end_ip_address       = cidrhost(each.value, -1)
}

resource "azurerm_synapse_managed_private_endpoint" "data_lake" {
  name                 = "synapse-st-dfs--${var.data_lake_account_name}"
  synapse_workspace_id = azurerm_synapse_workspace.synapse.id
  target_resource_id   = data.azurerm_storage_account.data_lake.id
  subresource_name     = "dfs"

  depends_on = [
    azurerm_synapse_role_assignment.deployment_principal
  ]
}

resource "azurerm_synapse_private_link_hub" "synapse" {
  count = var.enable_private_networking ? 1 : 0

  name                = replace("pl-syn-ws-${var.resource_suffix}", "-", "")
  resource_group_name = var.resource_group_name
  location            = var.location

  tags = local.tags
}

resource "time_sleep" "firewall_delay" {
  create_duration = "30s"

  depends_on = [
    azurerm_synapse_firewall_rule.allow_all_azure
  ]
}
