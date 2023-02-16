data "azurerm_client_config" "deployment" {}

data "azurerm_resource_group" "deployment_group" {
  name = var.resource_group_name
}

locals {
  # Append /32 CIDR suffix to IP address without a CIDR suffix
  firewall_allowed_ip_addresses = [
    for address in var.firewall_allowed_ip_addresses : can(split("/", address)[1]) ? address : "${address}/32"
  ]

  # Map of Synapse Workspace endpoints for dynamic private endpoint provisioning
  synapse_private_endpoints = {
    "SynapseDedicatedSql" = {
      endpoint_name      = "pe-syn-dsql-${var.resource_suffix}"
      subresource_names  = ["SQL"]
      target_resource_id = azurerm_synapse_workspace.synapse.id
    },
    "SynapseDevelopment" = {
      endpoint_name      = "pe-syn-dev-${var.resource_suffix}"
      subresource_names  = ["DEV"]
      target_resource_id = azurerm_synapse_workspace.synapse.id
    },
    "SynapseServerlessSql" = {
      endpoint_name      = "pe-syn-ssql-${var.resource_suffix}"
      subresource_names  = ["SqlOnDemand"]
      target_resource_id = azurerm_synapse_workspace.synapse.id
    },
    "SynapseWorkspace" = {
      endpoint_name      = "pe-syn-ws-${var.resource_suffix}"
      subresource_names  = ["Web"]
      target_resource_id = try(azurerm_synapse_private_link_hub.synapse[0].id, null)
    }
  }

  # Only create private endpoints if private networking is enabled
  synapse_private_endpoints_to_create = var.enable_private_networking ? keys(local.synapse_private_endpoints) : []

  # Reduce RBAC data structure into a flat format for dynamic role assignment
  synapse_role_assignments = flatten([
    for role, principals in var.synapse_role_assignments : [
      for principal in principals : {
        role_definition_name = role
        principal_id         = principal
      }
    ]
  ])

  # Merge resource group tags, input tags, and module-specific tags
  tags = merge(
    data.azurerm_resource_group.deployment_group.tags,
    var.tags,
    {
      ModuleName = "synapse-workspace"
    }
  )
}
