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

variable "enable_monitoring" {
  default     = false
  description = "Determines if resources should be linked to a Log Analytics workspace for monitoring"
  type        = bool
}

variable "enable_private_networking" {
  default     = false
  description = "Determines if resources should be linked to a private network with restricted public access"
  type        = bool
}

variable "enable_spark_pool" {
  default     = true
  description = "Determines if an Apache Spark pool should be deployed within the Synapse Workspace"
  type        = bool
}

variable "firewall_allowed_ip_addresses" {
  default     = []
  description = "A list of CIDR ranges to be permitted access to the data lake Storage Account"
  type        = list(string)
}

variable "log_analytics_resource_group_name" {
  default     = null
  description = "The name of the resource group containing the Log Analytics Workspace to use for log and metric monitoring"
  type        = string
}

variable "log_analytics_workspace_name" {
  default     = null
  description = "The name of the Log Analytics Workspace to use for log and metric monitoring"
  type        = string
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
    name      = "dsqlpool"
    sku       = "DW100c"
    collation = "SQL_Latin1_General_CP1_CI_AS"
  }
  ```
  EOT
  type        = map(string)
}

variable "synapse_dedicated_sql_pool_monitoring_logs" {
  default     = ["AllMetrics"]
  description = "A list of Synapse Workspace dedicated SQL pool log namespaces to monitor if monitoring is enabled"
  type        = list(string)
}

variable "synapse_dedicated_sql_pool_monitoring_metrics" {
  default = [
    "DmsWorkers",
    "ExecRequests",
    "RequestSteps",
    "SQLSecurityAuditEvents",
    "SqlRequests",
    "Waits"
  ]
  description = "A list of Synapse Workspace dedicated SQL pool metric namespaces to monitor if monitoring is enabled"
  type        = list(string)
}

variable "synapse_monitoring_logs" {
  default = [
    "BuiltinSqlReqsEnded",
    "GatewayApiRequests",
    "IntegrationActivityRuns",
    "IntegrationPipelineRuns",
    "IntegrationTriggerRuns",
    "SQLSecurityAuditEvents",
    "SynapseLinkEvent",
    "SynapseRbacOperations"
  ]
  description = "A list of Synapse Workspace log namespaces to monitor if monitoring is enabled"
  type        = list(string)
}

variable "synapse_monitoring_metrics" {
  default     = ["AllMetrics"]
  description = "A list of Synapse Workspace metric namespaces to monitor if monitoring is enabled"
  type        = list(string)
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

variable "synapse_spark_pool" {
  default = {
    name                     = "sparkpool"
    auto_pause_delay_minutes = 15
    max_node_count           = 12
    min_node_count           = 3
    size                     = "Small"
    version                  = "3.2"
    requirements             = null
  }
  description = <<-EOT
  A map describing the configuration for the Synapse Workspace Spark pool if enabled:
  ```
  {
    name                     = "sparkpool"
    auto_pause_delay_minutes = 15
    max_node_count           = 12
    min_node_count           = 3
    size                     = "Small"
    version                  = "3.2"
    requirements             = file("requirements.txt")
  }
  ```
  EOT
  type        = map(string)
}

variable "synapse_spark_pool_monitoring_logs" {
  default     = ["Apache Spark Pool"]
  description = "A list of Synapse Workspace Spark pool log namespaces to monitor if monitoring is enabled"
  type        = list(string)
}

variable "synapse_spark_pool_monitoring_metrics" {
  default     = ["BigDataPoolAppsEnded"]
  description = "A list of Synapse Workspace Spark pool metric namespaces to monitor if monitoring is enabled"
  type        = list(string)
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
