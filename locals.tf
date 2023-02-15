data "azurerm_client_config" "deployment" {}

data "azurerm_resource_group" "deployment_group" {
  name = var.resource_group_name
}

locals {
  # Append /32 CIDR suffix to IP address without a CIDR suffix
  firewall_allowed_ip_addresses = [
    for address in var.firewall_allowed_ip_addresses : can(split("/", address)[1]) ? address : "${address}/32"
  ]

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
