#Add role contributor do RG Aleteia Test ao Service principal
resource "azurerm_role_assignment" "role_rgaleteia" {
  scope                = "/subscriptions/cd4ed2c4-eb6d-48d7-98b7-e6db50218b71/resourceGroups/rg-aleteia-test"
  role_definition_name = "Contributor"
  principal_id         = var.akssvcprincipal_id
}

#Add role contributor do RG Network Test ao Service principal
resource "azurerm_role_assignment" "role_rgnetwork01_test" {
  scope                = "/subscriptions/cd4ed2c4-eb6d-48d7-98b7-e6db50218b71/resourceGroups/rg-network-test"
  role_definition_name = "Contributor"
  principal_id         = var.akssvcprincipal_id
}

#Add role contributor do RG Network Test ao Service principal
resource "azurerm_role_assignment" "role_rgnetwork02_test" {
  scope                = "/subscriptions/cd4ed2c4-eb6d-48d7-98b7-e6db50218b71/resourceGroups/rg-network-test"
  role_definition_name = "Network Contributor"
  principal_id         = var.akssvcprincipal_id
}

#Add role contributor do RG Connectivity Test ao Service principal
resource "azurerm_role_assignment" "role_rgconnectivity01_test" {
  scope                = "/subscriptions/7a94c215-8ddc-4820-b85b-33dc5805a468/resourceGroups/rg-network-connectivity"
  role_definition_name = "Private DNS Zone Contributor"
  principal_id         = var.akssvcprincipal_id
}

#Add role contributor do RG Connectivity Test ao Service principal
resource "azurerm_role_assignment" "role_rgconnectivity02_test" {
  scope                = "/subscriptions/7a94c215-8ddc-4820-b85b-33dc5805a468/resourceGroups/rg-network-connectivity"
  role_definition_name = "Contributor"
  principal_id         = var.akssvcprincipal_id
}

#Criacao do AKS
resource "azurerm_kubernetes_cluster" "aks" {
  depends_on                        = [azurerm_log_analytics_workspace.aks-log]
  name                              = var.cluster_name
  location                          = var.location
  resource_group_name               = var.resource_group
  dns_prefix_private_cluster        = var.cluster_name
  private_cluster_enabled           = true
  private_dns_zone_id               = var.aksdnszone_id


  default_node_pool {
    name                = "aleteiapool"
    vm_size             = "Standard_D16s_v3"
    vnet_subnet_id      = azurerm_subnet.snetaks.id
    zones               = [1, 2, 3]
    enable_auto_scaling = true
    min_count           = 2
    max_count           = 2
    max_pods            = 110
    type                = "VirtualMachineScaleSets"
    os_disk_size_gb     = 128
    os_disk_type        = "Managed"
  }

  role_based_access_control_enabled = true
  
  key_vault_secrets_provider {
    secret_rotation_enabled  = true
    secret_rotation_interval = "5m"
  }

  service_principal {
    client_id     = "b15a3a69-c2be-4f9c-8941-4370347630b0" #var.akssvcprincipal_id
    client_secret = var.akssvcprincipalsecret
  }

  network_profile {
    network_plugin     = "kubenet"
    load_balancer_sku  = "standard"
    outbound_type      = "userDefinedRouting"
    pod_cidr           = "10.245.0.0/16"
    docker_bridge_cidr = "172.17.0.1/16"
    dns_service_ip     = "10.0.0.10"
    service_cidr       = "10.0.0.0/16"
  }
  
  oms_agent {
    log_analytics_workspace_id        = azurerm_log_analytics_workspace.aks-log.id
  }

  tags = local.common_tags
}

#Criacao do Log Analytics
resource "azurerm_log_analytics_workspace" "aks-log" {
  name                = "log-aleteia-test"
  location            = var.location
  resource_group_name = var.resource_group
  sku                 = "PerGB2018"
  retention_in_days   = 30

  tags = local.common_tags
}

#Criacao das roles para o RBAC do AKS
resource "azurerm_role_assignment" "aks" {
  depends_on           = [azurerm_kubernetes_cluster.aks]
  scope                = azurerm_kubernetes_cluster.aks.id
  role_definition_name = "Monitoring Metrics Publisher"
  principal_id         = var.akssvcprincipal_id
}
resource "azurerm_role_assignment" "aks_subnet" {
  depends_on           = [azurerm_kubernetes_cluster.aks]
  scope                = azurerm_subnet.snetaks.id
  role_definition_name = "Network Contributor"
  principal_id         = var.akssvcprincipal_id
}