terraform {
  backend "azurerm" {
    resource_group_name  = "rg-aleteia-test"
    storage_account_name = "sttfstatealeteiatest"
    container_name       = "remote-state"
    key                  = "azure-hml/terraform.tfstate"
  }
}