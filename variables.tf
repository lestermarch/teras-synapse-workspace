variable "data_lake_account_name" {
  description = "The name of the ADLS Storage Account"
  type        = string
}

variable "data_lake_adls_filesystem_id" {
  description = "The hierarchical filesystem ID of the ADLS Storage Account"
  type        = string
}

variable "data_lake_resource_group_name" {
  description = "The name of the resource group containing the ADLS Storage Account"
  type        = string
}

variable "enable_data_exfiltration_protection" {
  default     = false
  description = "Determines if data exfiltration protection should be enabled for the Synapse Workspace"
  type        = bool
}

variable "enable_dedicated_sql_pool" {
  default     = false
  description = "Determines if a dedicated SQL pool should be deployed within the Synapse Workspace"
  type        = bool
}

variable "enable_private_networking" {
  default     = false
  description = "Determines if resources should be linked to a private network with restricted public access"
  type        = bool
}

variable "firewall_allowed_ip_addresses" {
  default     = []
  description = "A list of CIDR ranges to be permitted access to the data lake Storage Account"
  type        = list(string)
}

variable "purview_account_id" {
  default     = null
  description = "The ID of the Purview account to link with the Synapse Workspace"
  type        = string
}

variable "resource_group_name" {
  description = "The name of the resource group into which resources should be deployed"
  type        = string
}

variable "resource_suffix" {
  description = "The resource suffix to append to resources"
  type        = string

  validation {
    condition     = can(regex("^[a-z]+(-[a-z]+)*$", var.resource_suffix))
    error_message = "Resource names should use only lowercase characters, numbers, and hyphens."
  }
}

variable "synapse_aad_administrator" {
  description = <<-EOT
  A map describing the Azure AD username, object ID, and tenant ID for the Synapse administrator account:
  ```
  {
    username  = "example@ascent.io"
    object_id = "00000000-0000-0000-0000-000000000000"
    tenant_id = "00000000-0000-0000-0000-000000000000"
  }
  ```
  EOT
  type        = map(string)
}

variable "synapse_dedicated_sql_pool" {
  default = {
    collation = "SQL_Latin1_General_CP1_CI_AS"
    name      = "dsqlpool"
    sku       = "DW100c"
  }
  description = <<-EOT
  A map describing the configuration for the Synapse Workspace dedicated SQL pool if enabled:
  ```
  {
    collation = "SQL_Latin1_General_CP1_CI_AS"
    name      = "dsqlpool"
    sku       = "DW100c"
  }
  ```
  EOT
  type        = map(string)
}

variable "synapse_private_dns_zone_ids" {
  default     = []
  description = "A list of Private DNS Zone IDs in which to register the Synapse Workspace private endpoints if enabled"
  type        = list(string)
}

variable "synapse_private_endpoint_subnet_name" {
  default     = null
  description = "The subnet name in which to register the Synapse Workspace private endpoints if enabled"
  type        = string
}

variable "synapse_role_assignments" {
  default     = {}
  description = <<-EOT
  An object mapping RBAC roles to principal IDs for the Synapse Workspace:
  ```
  {
    "Synapse Administrator" = [
      "00000000-0000-0000-0000-000000000000"
    ],
    "Synapse Contributor" = [
      "00000000-0000-0000-0000-000000000000"
    ]
  }
  ```
  EOT
  type        = map(list(string))
}

variable "tags" {
  default     = {}
  description = <<-EOT
  A collection of tags to assign to taggable resources:
  ```
  {
    CreatedBy   = "Terraform",
    Environment = "Dev"
  }
  ```
  EOT
  type        = map(string)
}

variable "vnet_name" {
  default     = null
  description = "The name of the Virtual Network to use for private connectivity"
  type        = string
}

variable "vnet_resource_group_name" {
  default     = null
  description = "The name of the resource group containing the Virtual Network to use for private connectivity"
  type        = string
}
