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

resource "azurerm_kubernetes_cluster" "main" {
  name                = "aks-${var.environment}-devops"
  location            = var.aks_location
  resource_group_name = azurerm_resource_group.main.name
  dns_prefix          = "aks-staging-devops-dns"

  oidc_issuer_enabled          = true
  workload_identity_enabled    = true
  image_cleaner_enabled        = true
  image_cleaner_interval_hours = 168

  default_node_pool {
    name                = "agentpool"
    node_count          = var.node_count
    vm_size             = "Standard_DS2_v2"
    enable_auto_scaling = true
    min_count           = 2
    max_count           = 5
    zones               = ["1", "2", "3"]
  }

  identity {
    type = "SystemAssigned"
  }

  tags = {
    environment = var.environment
    project     = "devops-academia"
    team        = "devops"
  }
}
