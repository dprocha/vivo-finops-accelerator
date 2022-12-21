provider "azurerm" {
  features {}
}

terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "3.28.0"
    }
  }
}

provider "azurerm" {
  alias = "env"

  tenant_id       = var.tenant_id
  subscription_id = var.subscription_id

  features {}
}

provider "azurerm" {
  alias = "connectivity"

  tenant_id       = var.tenant_id
  subscription_id = var.subscription_connectivity

  features {}
}