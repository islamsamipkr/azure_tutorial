#This is an Azure Montreal College Tutorial for Storage Account creation--->Storage Container name Creation--->Storage Blob Creation
locals{ 
  cluster_names=["mcitk8s","mcitk8s2","mcitk8s3","mcitk8s4"]
}
resource "azurerm_resource_group" "azureresourcegroup" {
  name     = "MCIT_resource_group"
  location = "Canada Central"
}
