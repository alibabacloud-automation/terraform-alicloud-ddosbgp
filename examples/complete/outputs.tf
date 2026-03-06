output "ddosbgp_instance_id" {
  description = "The ID of the DDoS BGP instance"
  value       = module.ddosbgp.ddosbgp_instance_id
}

output "ddosbgp_instance_status" {
  description = "The status of the DDoS BGP instance"
  value       = module.ddosbgp.ddosbgp_instance_status
}

output "ddosbgp_instance_name" {
  description = "The name of the DDoS BGP instance"
  value       = module.ddosbgp.ddosbgp_instance_name
}

output "protected_ips" {
  description = "Map of protected IP addresses and their configurations"
  value       = module.ddosbgp.protected_ips
}

output "protected_ip_addresses" {
  description = "List of protected IP addresses"
  value       = module.ddosbgp.protected_ip_addresses
}

output "ddosbgp_policy_id" {
  description = "The ID of the DDoS BGP policy"
  value       = module.ddosbgp.ddosbgp_policy_id
}

output "ddosbgp_policy_name" {
  description = "The name of the DDoS BGP policy"
  value       = module.ddosbgp.ddosbgp_policy_name
}

output "module_summary" {
  description = "Summary of all DDoS BGP resources created by this module"
  value       = module.ddosbgp.module_summary
}

output "created_eip_addresses" {
  description = "List of created EIP addresses"
  value       = var.create_eips ? alicloud_eip_address.example[*].ip_address : []
}

output "created_eip_ids" {
  description = "List of created EIP resource IDs"
  value       = var.create_eips ? alicloud_eip_address.example[*].id : []
}