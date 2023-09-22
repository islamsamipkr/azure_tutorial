# Rename these outputs in one of the files (main.tf or kubernetes.tf) to make them unique
output "client_certificate_main" {
  value     = azurerm_kubernetes_cluster.k8scluster[*].client_certificate.name
  sensitive = true
}

output "kube_config_main" {
  value = azurerm_kubernetes_cluster.k8scluster[*].kube_config_raw
  sensitive = true
}
