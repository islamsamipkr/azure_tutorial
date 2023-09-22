# Rename these outputs in one of the files (main.tf or kubernetes.tf) to make them unique
output "client_certificate_main" {
  value     = azurerm_kubernetes_cluster.k8scluster[*].kube_config.0.client_certificate
  sensitive = true
}

output "kube_config_main" {
  value     = azurerm_kubernetes_cluster.k8scluster[*].kube_config_raw.0
  sensitive = true
}
