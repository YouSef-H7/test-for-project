output "aks_name" {
  description = "The name of the AKS cluster."
  value       = azurerm_kubernetes_cluster.aks.name
}

output "aks_id" {
  description = "The ID of the AKS cluster."
  value       = azurerm_kubernetes_cluster.aks.id
}

output "kube_config" {
  description = "Kubeconfig used to access the AKS cluster."
  value       = azurerm_kubernetes_cluster.aks.kube_config_raw
  sensitive   = true
}

output "kubelet_identity_object_id" {
  description = "The Object ID of the kubelet identity used for ACR integration."
  value       = azurerm_kubernetes_cluster.aks.kubelet_identity[0].object_id
}
