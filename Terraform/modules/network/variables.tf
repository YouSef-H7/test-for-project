variable "resource_group_name" { type = string }
variable "location" { type = string }

variable "vnet_name" {
  type    = string
  default = "vnet-team4"
}

variable "vnet_address_space" {
  type    = string
  default = "10.0.0.0/16"
}

variable "subnet_name" {
  type    = string
  default = "subnet-aks"
}

variable "subnet_prefix" {
  type    = string
  default = "10.0.1.0/24"
}
