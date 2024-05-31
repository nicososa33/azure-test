locals {
  region = "use2"

  version_terraform    = ">= 1.6.0, <= 1.6.3"
  version_terragrunt   = "=0.53.2"
  version_provider_azurerm = ">=3.11"

  root_tags = {
    project = "test-terraform-terragrunt"
  }
}

generate "backend" {
  path      = "provider.tf"
  if_exists = "overwrite"
  contents  = <<EOF
terraform {
  required_version = "${local.version_terraform}"
  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
      version = "${local.version_provider_azurerm}"
    }
remote_state {
  backend = "azurerm"
  config = {
    resource_group_name   = "my-resource-group"
    storage_account_name  = "mystorageaccount"
    container_name       = "mycontainer"
    key                   = "${path_relative_to_include()}/terraform.tfstate"
  }
}

provider "azurerm" {
  alias           = "connectivity"
  subscription_id = "00000000-0000-0000-0000-000000000000"
  features {}
}
EOF
}