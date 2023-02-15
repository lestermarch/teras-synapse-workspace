terraform {
  # https://github.com/hashicorp/terraform/tags
  required_version = "~> 1.3.0"

  required_providers {
    # https://registry.terraform.io/providers/hashicorp/azurerm/latest
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.0"
    }
    # https://registry.terraform.io/providers/hashicorp/time/latest
    time = {
      source  = "hashicorp/time"
      version = "~> 0.9.0"
    }
  }
}
