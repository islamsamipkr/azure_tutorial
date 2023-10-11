output "local_waf_policy_list"{
value={for policy in local.waf_policy_list:policy}
}
