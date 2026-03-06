# DDoS BGP Instance outputs
output "ddosbgp_instance_id" {
  description = "The ID of the DDoS BGP instance"
  value       = var.create_instance ? alicloud_ddosbgp_instance.instance[0].id : var.ddosbgp_instance_id
}

output "ddosbgp_instance_status" {
  description = "The status of the DDoS BGP instance"
  value       = var.create_instance ? alicloud_ddosbgp_instance.instance[0].status : null
}

output "ddosbgp_instance_name" {
  description = "The name of the DDoS BGP instance"
  value       = var.create_instance ? alicloud_ddosbgp_instance.instance[0].instance_name : null
}

output "ddosbgp_instance_type" {
  description = "The type of the DDoS BGP instance"
  value       = var.create_instance ? alicloud_ddosbgp_instance.instance[0].type : null
}

output "ddosbgp_instance_bandwidth" {
  description = "The bandwidth of the DDoS BGP instance"
  value       = var.create_instance ? alicloud_ddosbgp_instance.instance[0].bandwidth : null
}

output "ddosbgp_instance_base_bandwidth" {
  description = "The base bandwidth of the DDoS BGP instance"
  value       = var.create_instance ? alicloud_ddosbgp_instance.instance[0].base_bandwidth : null
}

output "ddosbgp_instance_normal_bandwidth" {
  description = "The normal bandwidth of the DDoS BGP instance"
  value       = var.create_instance ? alicloud_ddosbgp_instance.instance[0].normal_bandwidth : null
}

output "ddosbgp_instance_ip_count" {
  description = "The IP count of the DDoS BGP instance"
  value       = var.create_instance ? alicloud_ddosbgp_instance.instance[0].ip_count : null
}

output "ddosbgp_instance_ip_type" {
  description = "The IP type of the DDoS BGP instance"
  value       = var.create_instance ? alicloud_ddosbgp_instance.instance[0].ip_type : null
}

# Protected IPs outputs
output "protected_ips" {
  description = "Map of protected IP addresses and their configurations"
  value = {
    for k, v in alicloud_ddosbgp_ip.protected_ips : k => {
      id         = v.id
      ip_address = v.ip
      status     = v.status
      member_uid = v.member_uid
    }
  }
}

output "protected_ip_addresses" {
  description = "List of protected IP addresses"
  value       = [for ip in alicloud_ddosbgp_ip.protected_ips : ip.ip]
}

output "protected_ip_ids" {
  description = "List of protected IP resource IDs"
  value       = [for ip in alicloud_ddosbgp_ip.protected_ips : ip.id]
}

# DDoS BGP Policy outputs
output "ddosbgp_policy_id" {
  description = "The ID of the DDoS BGP policy"
  value       = var.create_policy ? alicloud_ddos_bgp_policy.policy[0].id : null
}

output "ddosbgp_policy_name" {
  description = "The name of the DDoS BGP policy"
  value       = var.create_policy ? alicloud_ddos_bgp_policy.policy[0].policy_name : null
}

output "ddosbgp_policy_type" {
  description = "The type of the DDoS BGP policy"
  value       = var.create_policy ? alicloud_ddos_bgp_policy.policy[0].type : null
}

# Summary outputs
output "module_summary" {
  description = "Summary of all DDoS BGP resources created by this module"
  value = {
    instance_id         = var.create_instance ? alicloud_ddosbgp_instance.instance[0].id : var.ddosbgp_instance_id
    instance_created    = var.create_instance
    protected_ips_count = length(alicloud_ddosbgp_ip.protected_ips)
    policy_created      = var.create_policy
    policy_id           = var.create_policy ? alicloud_ddos_bgp_policy.policy[0].id : null
  }
}