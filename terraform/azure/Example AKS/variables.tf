variable "tenant_id" {
  type        = string
  description = "Tenant ID a ser usado pela execucao do Terraform"
  default     = ""
}

variable "subscription_id" {
  type        = string
  description = "Subscription a ser usado pela execucao do Terraform"
  default     = ""
}

variable "resource_group" {
  type        = string
  description = "Nome do Resource group"
  default     = ""
}

variable "location" {
  type        = string
  description = "Localizacao de resources na azure"
  default     = "Brazil South"
}

variable "cluster_name" {
  type        = string
  description = "Nome do cluster AKS"
  default     = ""
}

variable "admin_group" {
  type        = string
  description = "Grupo que sera administrador do AKS via RBAC"
  default     = ""
}

variable "vnet_name" {
  type        = string
  description = "Nome da Vnet existente na Azure"
  default     = ""
}

variable "subnet_name" {
  type        = string
  description = "Nome da subnet AKS"
  default     = "snet-aks-aleteia-test-brsouth"
}

variable "subnet_pvt_endpt" {
  type        = string
  description = "Nome da subnet Private Endpoint SQL"
  default     = "snet-test-brsouth-middle"
}

variable "private_dns_name" {
  type        = string
  description = "Nome do DNS privado existente na Azure"
  default     = ""
}

variable "subscription_connectivity" {
  type        = string
  description = "Subcription ID Connectivity"
  default     = ""
}

variable "rg_connectivity" {
  type        = string
  description = "Resource Group da zona DNS privada"
  default     = ""
}

variable "vnet_connectivity" {
  type        = string
  description = "Resource Group da zona DNS privada"
  default     = ""
}


variable "rg_vnet" {
  type        = string
  description = "Resource Group da zona DNS privada"
  default     = ""
}

variable "rg_nsg" {
  type        = string
  description = "Resource Group da zona DNS privada"
  default     = ""
}

variable "nsg_name" {
  type        = string
  description = "Nome do NSG existente na Azure"
  default     = ""
}

variable "akssvcprincipal_id" {
  type        = string
  description = "Object ID do akssvcprincipal"
  default     = ""
}

variable "akssvcprincipalsecret" {
  type        = string
  description = "Nome do NSG existente na Azure"
  default     = ""
}

variable "aksroutetable" {
  type        = string
  description = "Nome da UDR Aleteia"
  default     = ""
}

variable "aksdnszone_id" {
  type        = string
  description = "ID da zona dns"
  default     = "/subscriptions/7a94c215-8ddc-4820-b85b-33dc5805a468/resourceGroups/rg-network-connectivity/providers/Microsoft.Network/privateDnsZones/privatelink.brazilsouth.azmk8s.io"
}

locals {
  common_tags = {
    idorcamento = "ID000040"
    projeto     = "Aleteia"
    trilha      = "Test"
  }
}