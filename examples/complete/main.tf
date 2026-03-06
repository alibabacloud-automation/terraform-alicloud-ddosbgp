# Configure the Alicloud Provider
provider "alicloud" {
  region = var.region
}

# Create EIP addresses for DDoS BGP protection (example)
resource "alicloud_eip_address" "example" {
  count                = var.create_eips ? length(var.protected_ip_names) : 0
  address_name         = var.protected_ip_names[count.index]
  bandwidth            = var.eip_bandwidth
  internet_charge_type = var.eip_internet_charge_type
  payment_type         = var.eip_payment_type
  tags                 = var.common_tags
}


# Call the DDoS BGP module
module "ddosbgp" {
  source = "../../"

  ###################
  # DDoS BGP Instance
  ###################
  create_instance = var.create_ddosbgp_instance
  instance_config = {
    instance_name     = var.ddosbgp_instance_name
    base_bandwidth    = var.ddosbgp_base_bandwidth
    bandwidth         = var.ddosbgp_bandwidth
    ip_count          = var.ddosbgp_ip_count
    ip_type           = var.ddosbgp_ip_type
    normal_bandwidth  = var.ddosbgp_normal_bandwidth
    type              = var.ddosbgp_type
    period            = var.ddosbgp_period
    resource_group_id = var.resource_group_id
  }

  ###################
  # Protected IPs
  ###################
  protected_ips_config = var.create_eips ? {
    for i, name in var.protected_ip_names : name => {
      ip_address = alicloud_eip_address.example[i].ip_address
      member_uid = var.member_uid
    }
  } : var.existing_protected_ips_config

  ###################
  # DDoS BGP Policy
  ###################
  create_policy = var.create_ddosbgp_policy
  policy_config = {
    policy_name = var.ddosbgp_policy_name
    type        = var.ddosbgp_policy_type
  }

  policy_content = {
    enable_defense = true
  }

  ###################
  # Common Tags
  ###################
  tags = var.common_tags
}