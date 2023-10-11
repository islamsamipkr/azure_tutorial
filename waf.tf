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
        for_each = {for i, cr in custom_rules.match_conditions: i => cr}
        content {
          operator            = cr.operator
          negation_condition  = cr.negation_condition
          match_values        = cr.match_values
          dynamic "match_variables" {
            for_each = {for i, mv in cr.match_variables: i => mv}
            content {
              variable_name = mv.variable_name
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
        for_each = {for i, mrs in managed_rules.managed_rule_set: i => mrs}
        content {
          type      = mrs.type
          version   = mrs.version
        }
      }
    }
  } 
}