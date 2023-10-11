resource "azurerm_web_application_firewall_policy" "wafpol" {
  for_each            = {for policy in local.waf_policy_list: "${policy.name}" => policy}
  name                = each.value.name
  resource_group_name = azurerm_resource_group.azureresourcegroup.name
  location            = azurerm_resource_group.azureresourcegroup.location

  custom_rules {
    name      = each.value.custom_rules.name
    priority  = each.value.custom_rules.priority 
    rule_type = each.value.custom_rules.rule_type

    match_conditions {
      match_variables {
        variable_name = each.value.custom_rules.variable_name
      }

      operator           = each.value.custom_rules.operator
      negation_condition = each.value.custom_rules.negation_condition
      match_values       = each.value.custom_rules.match_values
    }
    action = each.value.custom_rules.action

  }
  managed_rules {

    managed_rule_set {
      type    = each.value.managed_rules.type
      version = each.value.managed_rules.version
    }
  }
}
