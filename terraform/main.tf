resource "azurerm_resource_group" "main" {
  name     = "rg-devops-academia"
  location = var.location

  tags = {
    environment = var.environment
    project     = "devops-academia"
    team        = "devops"
  }
}

resource "azurerm_virtual_network" "main" {
  name                = "vnet-${var.environment}-devops"
  address_space       = ["10.0.0.0/16"]
  location            = var.location
  resource_group_name = azurerm_resource_group.main.name

  tags = {
    environment = var.environment
    project     = "devops-academia"
  }
}

resource "azurerm_storage_account" "main" {
  name                     = "st${var.environment}devopssri${substr(md5(var.environment), 0, 4)}"
  resource_group_name      = azurerm_resource_group.main.name
  location                 = var.location
  account_tier             = "Standard"
  account_replication_type = "LRS"

  tags = {
    environment = var.environment
    project     = "devops-academia"
  }
}