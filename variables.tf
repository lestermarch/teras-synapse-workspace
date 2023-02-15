variable "data_lake_adls_filesystem_id" {
  description = "The hierarchical filesystem ID of the ADLS Storage Account"
  type        = string
}

variable "enable_data_exfiltration_protection" {
  default     = false
  description = "Determines if data exfiltration protection should be enabled for the Synapse Workspace"
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
  description = "A map describing the login username and Azure AD object ID for the Syanapse administrator account"
  type        = map(string)
}

variable "synapse_role_assignments" {
  default     = {}
  description = "An object mapping RBAC roles to principal IDs for the Synapse Workspace"
  type        = map(list(string))
}

variable "tags" {
  default     = {}
  description = "A collection of tags to assign to taggable resources"
  type        = map(string)
}
