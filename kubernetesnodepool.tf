resource "azurerm_kubernetes_cluster_node_pool" "kube1nodepool" {
 for_each               = {for cluster in azurerm_kubernetes_cluster.kube1: cluster.name=>cluster.id}
 name                   = "${each.key}"
 kubernetes_cluster_id  = tostring(each.value)
 vm_size                = "Standard_DS2_v2"
 node_count             = 1

  tags = {
    Environment = "Production"
  }
}
