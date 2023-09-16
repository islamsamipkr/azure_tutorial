resource "azurerm_resource_group""batcha06"{
    name="batch_A06_Resource_Group"
    location="Canada Central"   
}
resource "azurerm_storage_account" "awp" {
  name                     = "storageaccountname"
  resource_group_name      = azurerm_resource_group.example.name
  location                 = azurerm_resource_group.example.location
  account_tier             = "Standard"
  account_replication_type = "GRS"

  tags = {
    environment = "staging"
  }
}


