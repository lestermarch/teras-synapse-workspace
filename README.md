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
| [azurerm_private_endpoint.synapse](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/private_endpoint) | resource |
| [azurerm_synapse_firewall_rule.allow_all](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/synapse_firewall_rule) | resource |
| [azurerm_synapse_firewall_rule.allow_all_azure](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/synapse_firewall_rule) | resource |
| [azurerm_synapse_firewall_rule.allowed_ips](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/synapse_firewall_rule) | resource |
| [azurerm_synapse_managed_private_endpoint.data_lake](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/synapse_managed_private_endpoint) | resource |
| [azurerm_synapse_private_link_hub.synapse](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/synapse_private_link_hub) | resource |
| [azurerm_synapse_role_assignment.deployment_principal](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/synapse_role_assignment) | resource |
| [azurerm_synapse_role_assignment.synapse](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/synapse_role_assignment) | resource |
| [azurerm_synapse_workspace.synapse](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/synapse_workspace) | resource |
| [azurerm_synapse_workspace_aad_admin.synapse](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/synapse_workspace_aad_admin) | resource |
| [time_sleep.firewall_delay](https://registry.terraform.io/providers/hashicorp/time/latest/docs/resources/sleep) | resource |
| [azurerm_client_config.deployment](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/client_config) | data source |
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
| <a name="input_enable_private_networking"></a> [enable\_private\_networking](#input\_enable\_private\_networking) | Determines if resources should be linked to a private network with restricted public access | `bool` | `false` | no |
| <a name="input_firewall_allowed_ip_addresses"></a> [firewall\_allowed\_ip\_addresses](#input\_firewall\_allowed\_ip\_addresses) | A list of CIDR ranges to be permitted access to the data lake Storage Account | `list(string)` | `[]` | no |
| <a name="input_purview_account_id"></a> [purview\_account\_id](#input\_purview\_account\_id) | The ID of the Purview account to link with the Synapse Workspace | `string` | `null` | no |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | The name of the resource group into which resources should be deployed | `string` | n/a | yes |
| <a name="input_resource_suffix"></a> [resource\_suffix](#input\_resource\_suffix) | The resource suffix to append to resources | `string` | n/a | yes |
| <a name="input_synapse_aad_administrator"></a> [synapse\_aad\_administrator](#input\_synapse\_aad\_administrator) | A map describing the Azure AD username, object ID, and tenant ID for the Synapse administrator account:<br>{<br>  username  = "example@ascent.io"<br>  object\_id = "00000000-0000-0000-0000-000000000000"<br>  tenant\_id = "00000000-0000-0000-0000-000000000000"<br>} | `map(string)` | n/a | yes |
| <a name="input_synapse_private_dns_zone_ids"></a> [synapse\_private\_dns\_zone\_ids](#input\_synapse\_private\_dns\_zone\_ids) | A list of Private DNS Zone IDs in which to register the Synapse Workspace private endpoints if enabled | `list(string)` | `[]` | no |
| <a name="input_synapse_private_endpoint_subnet_name"></a> [synapse\_private\_endpoint\_subnet\_name](#input\_synapse\_private\_endpoint\_subnet\_name) | The subnet name in which to register the Synapse Workspace private endpoints if enabled | `string` | `null` | no |
| <a name="input_synapse_role_assignments"></a> [synapse\_role\_assignments](#input\_synapse\_role\_assignments) | An object mapping RBAC roles to principal IDs for the Synapse Workspace:<br>{<br>  "Synapse Administrator" = [<br>    "00000000-0000-0000-0000-000000000000"<br>  ],<br>  "Synapse Contributor" = [<br>    "00000000-0000-0000-0000-000000000000"<br>  ]<br>} | `map(list(string))` | `{}` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | A collection of tags to assign to taggable resources:<br>{<br>  CreatedBy   = "Terraform",<br>  Environment = "Dev"<br>} | `map(string)` | `{}` | no |
| <a name="input_vnet_name"></a> [vnet\_name](#input\_vnet\_name) | The name of the Virtual Network to use for private connectivity | `string` | `null` | no |
| <a name="input_vnet_resource_group_name"></a> [vnet\_resource\_group\_name](#input\_vnet\_resource\_group\_name) | The name of the resource group containing the Virtual Network to use for private connectivity | `string` | `null` | no |

## Outputs

No outputs.
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
