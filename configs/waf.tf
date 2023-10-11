resource "azurerm_web_application_firewall_policy" "wafpol" {
  for_each            = {for policy in local.waf_policy_list: "${policy.name}" => policy}
  name                = each.value.name
  resource_group_name = azurerm_resource_group.batch06.name
  location            = azurerm_resource_group.batch06.location

  custom_rules {
    name      = each.value.name
    priority  = each.value.priority 
    rule_type = each.value.rule_type

    match_conditions {
      match_variables {
        variable_name = each.value.variable_name
      }

      operator           = each.value.operator
      negation_condition = each.value.negation_condition
      match_values       = each.value.match_values
    }
    action = each.value.action

  }
}
}
