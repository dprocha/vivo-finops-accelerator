# SUBNET AKS Aleteia Test
resource "azurerm_subnet" "snetaks" {
  name                 = var.subnet_name
  resource_group_name  = var.rg_vnet
  virtual_network_name = var.vnet_name
  address_prefixes     = ["10.124.76.32/27"]
  service_endpoints = ["Microsoft.Storage"]

  private_endpoint_network_policies_enabled     = true
  }

resource "azurerm_subnet_route_table_association" "association_rt" {
  subnet_id      = azurerm_subnet.snetaks.id
  route_table_id = azurerm_route_table.rt.id
}

resource "azurerm_subnet_network_security_group_association" "example" {
  subnet_id                 = azurerm_subnet.snetaks.id
  network_security_group_id = azurerm_network_security_group.nsg.id
}