output "vnet_id" {
  value = module.network.vnet_id
}

output "acr_id" {
  value = module.acr.acr_id
}

output "aks_name" {
  value = module.aks.aks_name
}

output "kube_config" {
  value     = module.aks.kube_config
  sensitive = true
}
