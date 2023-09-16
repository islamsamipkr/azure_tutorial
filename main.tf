resource "azurerm_resource_group""batcha06"{
    name="${var.prefix}_Resource_Group_${var.env}"
    location="Canada Central"   
}

resource "azurerm_storage_account" "awp" {
  name                     = "${var.prefix}storageaccountname${var.env}"
  resource_group_name      = azurerm_resource_group.batcha06.name
  location                 = azurerm_resource_group.batcha06.location
  account_tier             = var.account_tier
  account_replication_type = "GRS"

  tags = {
    environment = "staging"
  }
}


