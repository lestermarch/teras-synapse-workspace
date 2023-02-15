# Teras Module
Lorem ipsum...

## Table of Contents
1. [Architecture](#architecture)
2. [Usage](#usage)
3. [Requirements](#requirements)
4. [Providers](#providers)
5. [Inputs](#inputs)
6. [Outputs](#outputs)

## Architecture
The below diagram provides an overview of the resources deployed in this module:

<img src="docs/architecture.svg">

## Usage
Example minimal deployment using module defaults:
```
module "teras_module" {
  source  = "..."
  version = "..."

  variable_a = "..."
  varialbe_b = "..."
}
```

| :scroll: Note: Defaults |
|----------|
| See [inputs](#inputs) for a complete list of input variables and their defaults. |

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | ~> 1.3.0 |
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) | ~> 3.0 |
| <a name="requirement_time"></a> [time](#requirement\_time) | ~> 0.9.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | 3.43.0 |
| <a name="provider_time"></a> [time](#provider\_time) | 0.9.1 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [azurerm_monitor_diagnostic_setting.synapse](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/monitor_diagnostic_setting) | resource |
| [azurerm_monitor_diagnostic_setting.synapse_dedicated_sql_pool](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/monitor_diagnostic_setting) | resource |
| [azurerm_monitor_diagnostic_setting.synapse_spark_pool](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/monitor_diagnostic_setting) | resource |
| [azurerm_private_endpoint.synapse](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/private_endpoint) | resource |
| [azurerm_synapse_firewall_rule.allow_all](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/synapse_firewall_rule) | resource |
| [azurerm_synapse_firewall_rule.allow_all_azure](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/synapse_firewall_rule) | resource |
| [azurerm_synapse_firewall_rule.allowed_ips](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/synapse_firewall_rule) | resource |
| [azurerm_synapse_managed_private_endpoint.data_lake](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/synapse_managed_private_endpoint) | resource |
| [azurerm_synapse_private_link_hub.synapse](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/synapse_private_link_hub) | resource |
| [azurerm_synapse_role_assignment.deployment_principal](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/synapse_role_assignment) | resource |
| [azurerm_synapse_role_assignment.synapse](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/synapse_role_assignment) | resource |
| [azurerm_synapse_spark_pool.synapse](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/synapse_spark_pool) | resource |
| [azurerm_synapse_sql_pool.synapse](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/synapse_sql_pool) | resource |
| [azurerm_synapse_workspace.synapse](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/synapse_workspace) | resource |
| [azurerm_synapse_workspace_aad_admin.synapse](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/synapse_workspace_aad_admin) | resource |
| [time_sleep.firewall_delay](https://registry.terraform.io/providers/hashicorp/time/latest/docs/resources/sleep) | resource |
| [azurerm_client_config.deployment](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/client_config) | data source |
| [azurerm_log_analytics_workspace.monitoring_workspace](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/log_analytics_workspace) | data source |
| [azurerm_resource_group.deployment_group](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/resource_group) | data source |
| [azurerm_storage_account.data_lake](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/storage_account) | data source |
| [azurerm_virtual_network.vnet](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/virtual_network) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_data_lake_account_name"></a> [data\_lake\_account\_name](#input\_data\_lake\_account\_name) | The name of the ADLS Storage Account | `string` | n/a | yes |
| <a name="input_data_lake_adls_filesystem_id"></a> [data\_lake\_adls\_filesystem\_id](#input\_data\_lake\_adls\_filesystem\_id) | The hierarchical filesystem ID of the ADLS Storage Account | `string` | n/a | yes |
| <a name="input_data_lake_resource_group_name"></a> [data\_lake\_resource\_group\_name](#input\_data\_lake\_resource\_group\_name) | The name of the resource group containing the ADLS Storage Account | `string` | n/a | yes |
| <a name="input_enable_data_exfiltration_protection"></a> [enable\_data\_exfiltration\_protection](#input\_enable\_data\_exfiltration\_protection) | Determines if data exfiltration protection should be enabled for the Synapse Workspace | `bool` | `false` | no |
| <a name="input_enable_dedicated_sql_pool"></a> [enable\_dedicated\_sql\_pool](#input\_enable\_dedicated\_sql\_pool) | Determines if a dedicated SQL pool should be deployed within the Synapse Workspace | `bool` | `false` | no |
| <a name="input_enable_monitoring"></a> [enable\_monitoring](#input\_enable\_monitoring) | Determines if resources should be linked to a Log Analytics workspace for monitoring | `bool` | `false` | no |
| <a name="input_enable_private_networking"></a> [enable\_private\_networking](#input\_enable\_private\_networking) | Determines if resources should be linked to a private network with restricted public access | `bool` | `false` | no |
| <a name="input_enable_spark_pool"></a> [enable\_spark\_pool](#input\_enable\_spark\_pool) | Determines if an Apache Spark pool should be deployed within the Synapse Workspace | `bool` | `true` | no |
| <a name="input_firewall_allowed_ip_addresses"></a> [firewall\_allowed\_ip\_addresses](#input\_firewall\_allowed\_ip\_addresses) | A list of CIDR ranges to be permitted access to the data lake Storage Account | `list(string)` | `[]` | no |
| <a name="input_log_analytics_resource_group_name"></a> [log\_analytics\_resource\_group\_name](#input\_log\_analytics\_resource\_group\_name) | The name of the resource group containing the Log Analytics Workspace to use for log and metric monitoring | `string` | `null` | no |
| <a name="input_log_analytics_workspace_name"></a> [log\_analytics\_workspace\_name](#input\_log\_analytics\_workspace\_name) | The name of the Log Analytics Workspace to use for log and metric monitoring | `string` | `null` | no |
| <a name="input_purview_account_id"></a> [purview\_account\_id](#input\_purview\_account\_id) | The ID of the Purview account to link with the Synapse Workspace | `string` | `null` | no |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | The name of the resource group into which resources should be deployed | `string` | n/a | yes |
| <a name="input_resource_suffix"></a> [resource\_suffix](#input\_resource\_suffix) | The resource suffix to append to resources | `string` | n/a | yes |
| <a name="input_synapse_aad_administrator"></a> [synapse\_aad\_administrator](#input\_synapse\_aad\_administrator) | A map describing the Azure AD username, object ID, and tenant ID for the Synapse administrator account:<pre>{<br>  username  = "example@ascent.io"<br>  object_id = "00000000-0000-0000-0000-000000000000"<br>  tenant_id = "00000000-0000-0000-0000-000000000000"<br>}</pre> | `map(string)` | n/a | yes |
| <a name="input_synapse_dedicated_sql_pool"></a> [synapse\_dedicated\_sql\_pool](#input\_synapse\_dedicated\_sql\_pool) | A map describing the configuration for the Synapse Workspace dedicated SQL pool if enabled:<pre>{<br>  name      = "dsqlpool"<br>  sku       = "DW100c"<br>  collation = "SQL_Latin1_General_CP1_CI_AS"<br>}</pre> | `map(string)` | <pre>{<br>  "collation": "SQL_Latin1_General_CP1_CI_AS",<br>  "name": "dsqlpool",<br>  "sku": "DW100c"<br>}</pre> | no |
| <a name="input_synapse_dedicated_sql_pool_monitoring_logs"></a> [synapse\_dedicated\_sql\_pool\_monitoring\_logs](#input\_synapse\_dedicated\_sql\_pool\_monitoring\_logs) | A list of Synapse Workspace dedicated SQL pool log namespaces to monitor if monitoring is enabled | `list(string)` | <pre>[<br>  "AllMetrics"<br>]</pre> | no |
| <a name="input_synapse_dedicated_sql_pool_monitoring_metrics"></a> [synapse\_dedicated\_sql\_pool\_monitoring\_metrics](#input\_synapse\_dedicated\_sql\_pool\_monitoring\_metrics) | A list of Synapse Workspace dedicated SQL pool metric namespaces to monitor if monitoring is enabled | `list(string)` | <pre>[<br>  "DmsWorkers",<br>  "ExecRequests",<br>  "RequestSteps",<br>  "SQLSecurityAuditEvents",<br>  "SqlRequests",<br>  "Waits"<br>]</pre> | no |
| <a name="input_synapse_monitoring_logs"></a> [synapse\_monitoring\_logs](#input\_synapse\_monitoring\_logs) | A list of Synapse Workspace log namespaces to monitor if monitoring is enabled | `list(string)` | <pre>[<br>  "BuiltinSqlReqsEnded",<br>  "GatewayApiRequests",<br>  "IntegrationActivityRuns",<br>  "IntegrationPipelineRuns",<br>  "IntegrationTriggerRuns",<br>  "SQLSecurityAuditEvents",<br>  "SynapseLinkEvent",<br>  "SynapseRbacOperations"<br>]</pre> | no |
| <a name="input_synapse_monitoring_metrics"></a> [synapse\_monitoring\_metrics](#input\_synapse\_monitoring\_metrics) | A list of Synapse Workspace metric namespaces to monitor if monitoring is enabled | `list(string)` | <pre>[<br>  "AllMetrics"<br>]</pre> | no |
| <a name="input_synapse_private_dns_zone_ids"></a> [synapse\_private\_dns\_zone\_ids](#input\_synapse\_private\_dns\_zone\_ids) | A list of Private DNS Zone IDs in which to register the Synapse Workspace private endpoints if enabled | `list(string)` | `[]` | no |
| <a name="input_synapse_private_endpoint_subnet_name"></a> [synapse\_private\_endpoint\_subnet\_name](#input\_synapse\_private\_endpoint\_subnet\_name) | The subnet name in which to register the Synapse Workspace private endpoints if enabled | `string` | `null` | no |
| <a name="input_synapse_role_assignments"></a> [synapse\_role\_assignments](#input\_synapse\_role\_assignments) | An object mapping RBAC roles to principal IDs for the Synapse Workspace:<pre>{<br>  "Synapse Administrator" = [<br>    "00000000-0000-0000-0000-000000000000"<br>  ],<br>  "Synapse Contributor" = [<br>    "00000000-0000-0000-0000-000000000000"<br>  ]<br>}</pre> | `map(list(string))` | `{}` | no |
| <a name="input_synapse_spark_pool"></a> [synapse\_spark\_pool](#input\_synapse\_spark\_pool) | A map describing the configuration for the Synapse Workspace Spark pool if enabled:<pre>{<br>  name                     = "sparkpool"<br>  auto_pause_delay_minutes = 15<br>  max_node_count           = 12<br>  min_node_count           = 3<br>  size                     = "Small"<br>  version                  = "3.2"<br>  requirements             = file("requirements.txt")<br>}</pre> | `map(string)` | <pre>{<br>  "auto_pause_delay_minutes": 15,<br>  "max_node_count": 12,<br>  "min_node_count": 3,<br>  "name": "sparkpool",<br>  "requirements": null,<br>  "size": "Small",<br>  "version": "3.2"<br>}</pre> | no |
| <a name="input_synapse_spark_pool_monitoring_logs"></a> [synapse\_spark\_pool\_monitoring\_logs](#input\_synapse\_spark\_pool\_monitoring\_logs) | A list of Synapse Workspace Spark pool log namespaces to monitor if monitoring is enabled | `list(string)` | <pre>[<br>  "Apache Spark Pool"<br>]</pre> | no |
| <a name="input_synapse_spark_pool_monitoring_metrics"></a> [synapse\_spark\_pool\_monitoring\_metrics](#input\_synapse\_spark\_pool\_monitoring\_metrics) | A list of Synapse Workspace Spark pool metric namespaces to monitor if monitoring is enabled | `list(string)` | <pre>[<br>  "BigDataPoolAppsEnded"<br>]</pre> | no |
| <a name="input_tags"></a> [tags](#input\_tags) | A collection of tags to assign to taggable resources:<pre>{<br>  CreatedBy   = "Terraform",<br>  Environment = "Dev"<br>}</pre> | `map(string)` | `{}` | no |
| <a name="input_vnet_name"></a> [vnet\_name](#input\_vnet\_name) | The name of the Virtual Network to use for private connectivity | `string` | `null` | no |
| <a name="input_vnet_resource_group_name"></a> [vnet\_resource\_group\_name](#input\_vnet\_resource\_group\_name) | The name of the resource group containing the Virtual Network to use for private connectivity | `string` | `null` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_synapse_dedicated_sql_pool_id"></a> [synapse\_dedicated\_sql\_pool\_id](#output\_synapse\_dedicated\_sql\_pool\_id) | The ID of the Synapse Workspace dedicated SQL pool if enabled |
| <a name="output_synapse_spark_pool_id"></a> [synapse\_spark\_pool\_id](#output\_synapse\_spark\_pool\_id) | The ID of the Synapse Workspace Spark pool if enabled |
| <a name="output_synapse_workspace_name"></a> [synapse\_workspace\_name](#output\_synapse\_workspace\_name) | The name of the Synapse Workspace |
| <a name="output_synapse_workspace_resource_group_name"></a> [synapse\_workspace\_resource\_group\_name](#output\_synapse\_workspace\_resource\_group\_name) | The name of the Synapse Workspace |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
