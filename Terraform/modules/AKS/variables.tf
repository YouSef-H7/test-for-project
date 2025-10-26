variable "aks_name" {
    description = "aks-4."
    type        = string
    default     = "aks-4"
  
}
variable "resource_group_name" {
    description = "The name of the resource group in which to create the AKS cluster."
    type        = string
    default     = "error-team-rg"
  
}

variable "location" {
    description = "value for location"
    type = string
    default = "germanywestcentral"

  
}
variable "vnet_subnet_id" {
  description = "The ID of the subnet where AKS nodes will be deployed."
  type        = string
  default     = null
}

variable "cluster_name" {
    description = "The name of the Azure Kubernetes Service (AKS) cluster."
    type        = string
    default     = "aks-cluster-team4"

}

variable "acr_id" {
  description = "The ID of the Azure Container Registry (ACR) to grant AKS AcrPull access."
  type        = string
}
