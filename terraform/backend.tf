terraform {
  backend "azurerm" {
    resource_group_name  = "rg-terraform-state"
    storage_account_name = "sttfstateariad2026"
    container_name       = "tfstate"
    key                  = "terraform.tfstate"
  }
}
