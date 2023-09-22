# Rename these outputs in one of the files (main.tf or kubernetes.tf) to make them unique
output "client_certificate_main" {
  value     = [for cluster in azurerm_kubernetes_cluster.k8scluster: cluster.kube_config.0.client_certificate]
#azurerm_kubernetes_cluster.k8scluster[*].kube_config.0.client_certificate

  sensitive = true
}

output "kube_config_main" {
  value     = [for cluster in azurerm_kubernetes_cluster.k8scluster: cluster.kube_config_raw.0]
  sensitive = true
}

#output "client_certificate" {
#  value = azurerm_kubernetes_cluster.example.kube_config.0.client_certificate
#}

#output "kube_config" {
#  value = azurerm_kubernetes_cluster.example.kube_config_raw
#}
