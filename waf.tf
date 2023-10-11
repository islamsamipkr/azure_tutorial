resource "azurerm_web_application_firewall_policy" "wafpol" {
  for_each            = {for policy in local.waf_policy_list: "${policy.name}" => policy}
  name                = each.value.name
  resource_group_name = azurerm_resource_group.azureresourcegroup.name
  location            = azurerm_resource_group.azureresourcegroup.location

  dynamic "custom_rules" {
    for_each = each.value.custom_rules
    content {
      name      = custom_rules.name
      priority  = custom_rules.priority
      rule_type = custom_rules.rule_type
      action = custom_rules.action

      dynamic "match_conditions" {
        for_each = custom_rules.match_conditions
        content {
          operator            = match_conditions.operator
          negation_condition  = match_conditions.negation_condition
          match_values        = match_conditions.match_values
          dynamic "match_variables" {
            for_each = match_conditions.match_variables
            content {
              variable_name = match_variables.variable_name
            }
          }
        }
      }
    }
  }

  dynamic managed_rules {
    for_each = each.value.managed_rules
    content {
      dynamic managed_rule_set {
        for_each = managed_rules.managed_rule_set
        content {
          type      = managed_rule_set.type
          version   = managed_rule_set.version
        }
      }
    }
  } 
}