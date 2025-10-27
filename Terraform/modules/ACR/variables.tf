variable "location" {
  description = "The Azure region where the resources will be created."
  type        = string
  default     = "germanywestcentral"

}

variable "acr_name" {
  description = "The name of the Azure Container Registry."
  type        = string
  default     = "acrteam4"
}
variable "resource_group_name" {
  description = "The name of the resource group in which to create the Azure Container Registry."
  type        = string
  default     = "error-team-rg2"

}