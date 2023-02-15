output "synapse_dedicated_sql_pool_id" {
  description = "Synapse Workspace dedicated SQL pool if enabled"
  value       = var.enable_dedicated_sql_pool ? one(azurerm_synapse_sql_pool.synapse).id : null
}

output "synapse_workspace_name" {
  description = "The name of the Synapse Workspace"
  value       = azurerm_synapse_workspace.synapse.name
}

output "synapse_workspace_resource_group_name" {
  description = "The name of the Synapse Workspace"
  value       = azurerm_synapse_workspace.synapse.resource_group_name
}
