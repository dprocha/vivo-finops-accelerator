resource "azurerm_network_security_group" "nsg" {
  name                = "nsg-aks-aleteia-test"
  location            = var.location
  resource_group_name = var.resource_group

  security_rule {
    name                       = "AllowCofredeSenha"
    priority                   = 103
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = 443
    source_address_prefix      = "10.124.65.198/32"
    destination_address_prefix = "*"
  }

  security_rule {
    name                       = "AllowCidrBlockCustomAnyInbound"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "*"
    source_port_range          = "*"
    destination_port_range     = "*"
    source_address_prefix      = "10.124.76.32/28"
    destination_address_prefix = "10.124.76.32/28"
  }

  security_rule {
    name                       = "AllowPods-Aleteia"
    priority                   = 102
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "*"
    source_port_range          = "*"
    destination_port_range     = "*"
    source_address_prefix      = "10.245.0.0/16"
    destination_address_prefix = "10.245.0.0/16"
  }
  security_rule {
    name                       = "AllowIndra"
    priority                   = 110
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range    = 443
    source_address_prefix      = "10.130.215.252/32"
    destination_address_prefix = "*"
  }
  security_rule {
    name                       = "AllowEveris-NTT"
    priority                   = 120
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_ranges     = ["443","7071-7073","4300","7484","7697","2022","7474","7687","5432"]
    source_address_prefixes      = ["10.238.100.11/32","10.130.28.0/23"]
    destination_address_prefix = "10.124.77.92/32"
  }

  security_rule {
    name                       = "AllowVPNBigIP"
    priority                   = 130
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "443"
    source_address_prefix      = "10.125.210.0/24"
    destination_address_prefix = "10.124.77.92/32"
  }

  security_rule {
    name                       = "AllowSubnetDevBackend"
    priority                   = 100
    direction                  = "Outbound"
    access                     = "Allow"
    protocol                   = "*"
    source_port_range          = "*"
    destination_port_range     = "*"
    source_address_prefix      = "*"
    destination_address_prefix = "10.124.68.192/26"
  }

  security_rule {
    name                       = "AllowInternalNetwork"
    priority                   = 110
    direction                  = "Outbound"
    access                     = "Allow"
    protocol                   = "*"
    source_port_range          = "*"
    destination_port_range     = "*"
    source_address_prefix      = "10.124.76.32/27"
    destination_address_prefix = "10.0.0.0/8"
  }
}
