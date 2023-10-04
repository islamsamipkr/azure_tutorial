locals{
  linux_app=[for f in fileset("${path.module}/configs", "[^_]*.yaml") : yamldecode(file("${path.module}/configs/${f}"))]
  linux_app_list = flatten([
    for app in local.linux_app : [
      for linuxapps in try(app.linux_app, []) :{
        name=linuxapps.name
        resource_group_name=linuxapps.resource_group
        location=linuxapps.location
        os_type=linuxapps.os_type
        sku_name=linuxapps.sku_name     
      }
    ]
])
}



resource "azurerm_service_plan" "batcha06sp" {
  for_each            ={for sp in local.linux_app_list: "$sp.name"=>sp }
  name                = "${each.key}"
  resource_group_name = azurerm_resource_group.azureresourcegroup.name
  location            = azurerm_resource_group.azureresourcegroup.location
  os_type             = each.value.os_type
  sku_name            = each.value.sku_name
}

resource "azurerm_linux_web_app" "batcha06webapp" {
  for_each            = azurerm_service_plan.batcha06sp
  name                = "{$each.key}"
  resource_group_name = azurerm_resource_group.batcha06.name
  location            = azurerm_service_plan.batcha06sp.location
  service_plan_id     = each.value.id

  site_config {}
}

