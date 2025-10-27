variable "resource_group_name" {
  type    = string
  default = "error-team-rg2"
}

variable "location" {
  type    = string
  default = "germanywestcentral"
}

variable "cluster_name" {
  type    = string
  default = "aks-cluster-team4"
}

variable "subscription_id" {
  description = "Azure Subscription ID"
  type        = string
}