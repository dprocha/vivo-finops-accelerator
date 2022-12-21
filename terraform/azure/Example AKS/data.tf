data "azurerm_subscription" "current" {}

data "azurerm_virtual_network" "vnet" {
  provider = azurerm.env
  name                = var.vnet_name
  resource_group_name = var.rg_vnet
}


data "azurerm_subnet" "snet_pvt_endp" {
  #provider = azurerm.env
  name                 = var.subnet_pvt_endpt
  virtual_network_name = var.vnet_name
  resource_group_name  = var.rg_vnet
}

data "azurerm_resource_group" "rg_connectivity" {
  provider = azurerm.connectivity
  name = var.rg_connectivity
}

data "azurerm_virtual_network" "vnet_connectivity" {
  provider = azurerm.connectivity
  name                = var.vnet_connectivity
  resource_group_name = var.rg_connectivity
}
data "azurerm_private_dns_zone" "dns_aleteia" {
  provider = azurerm.connectivity
  name                = var.private_dns_name
  resource_group_name = var.rg_connectivity
}

data "azurerm_private_dns_zone" "database_zone" {
  provider = azurerm.connectivity
  name                = "privatelink.database.windows.net"
  resource_group_name = data.azurerm_resource_group.rg_connectivity.name
}

data "azurerm_private_dns_zone" "datafactory_zone" {
  provider = azurerm.connectivity
  name                = "privatelink.datafactory.azure.net"
  resource_group_name = data.azurerm_resource_group.rg_connectivity.name
}

data "azurerm_network_security_group" "nsg" {
  provider = azurerm.env
  name                = var.nsg_name
  resource_group_name = var.rg_nsg
}