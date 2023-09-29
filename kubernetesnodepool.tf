resource "azurerm_kubernetes_cluster_node_pool" "kube1nodepool" {
 for_each               = azurerm_kubernetes_cluster.batchabcd
 name                   = azurerm_kubernetes_cluster.batchabcd.name
 kubernetes_cluster_id  = azurerm_kubernetes_cluster.batchabcd.id
 vm_size                = "Standard_DS2_v2"
 node_count             = 1

  tags = {
    Environment = "Production"
  }
}
