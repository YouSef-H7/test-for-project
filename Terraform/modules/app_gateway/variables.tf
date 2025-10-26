variable "appgw_name" {
  description = "The name of the Application Gateway"
  type        = string
  default     = "appgw-team4"
}

variable "location" {
  description = "The Azure region for the resources"
  type        = string
  default     = "germanywestcentral"
}

variable "resource_group_name" {
  description = "The resource group where the Application Gateway will be created"
  type        = string
}

variable "subnet_id" {
  description = "The subnet ID where the Application Gateway will be placed"
  type        = string
}
