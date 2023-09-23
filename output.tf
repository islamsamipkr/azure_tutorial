output "client_certificate_main" {
  value     = [for cluster in azurerm_kubernetes_cluster.k8scluster: cluster.kube_config.0.client_certificate]
  sensitive = true
}

output "kube_config_main" {
  value     = [for cluster in azurerm_kubernetes_cluster.k8scluster: cluster.kube_config_raw]
  sensitive = true
}
