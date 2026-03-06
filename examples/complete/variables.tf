variable "region" {
  description = "The region where resources will be created"
  type        = string
  default     = "cn-hangzhou"
}

variable "create_ddosbgp_instance" {
  description = "Whether to create a new DDoS BGP instance"
  type        = bool
  default     = true
}

variable "ddosbgp_instance_name" {
  description = "The name of the DDoS BGP instance"
  type        = string
  default     = "terraform-example-ddosbgp"
}

variable "ddosbgp_base_bandwidth" {
  description = "The base bandwidth of the DDoS BGP instance"
  type        = number
  default     = 20
}

variable "ddosbgp_bandwidth" {
  description = "The bandwidth of the DDoS BGP instance"
  type        = number
  default     = -1
}

variable "ddosbgp_ip_count" {
  description = "The number of IP addresses that can be protected"
  type        = number
  default     = 100
}

variable "ddosbgp_ip_type" {
  description = "The protection IP address type"
  type        = string
  default     = "IPv4"
}

variable "ddosbgp_normal_bandwidth" {
  description = "The normal clean bandwidth"
  type        = number
  default     = 100
}

variable "ddosbgp_type" {
  description = "The protection package type"
  type        = string
  default     = "Enterprise"
}

variable "ddosbgp_period" {
  description = "The duration to buy DDoS BGP instance (in month)"
  type        = number
  default     = 12
}

variable "resource_group_id" {
  description = "The resource group ID"
  type        = string
  default     = null
}

variable "create_eips" {
  description = "Whether to create EIP addresses for DDoS BGP protection"
  type        = bool
  default     = true
}

variable "protected_ip_names" {
  description = "List of names for protected IP addresses"
  type        = list(string)
  default     = ["terraform-example-eip-1", "terraform-example-eip-2"]
}

variable "eip_bandwidth" {
  description = "The bandwidth of the EIP"
  type        = number
  default     = 5
}

variable "eip_internet_charge_type" {
  description = "The billing method of the EIP"
  type        = string
  default     = "PayByBandwidth"
}

variable "eip_payment_type" {
  description = "The payment type of the EIP"
  type        = string
  default     = "PayAsYouGo"
}

variable "existing_protected_ips_config" {
  description = "Configuration for existing IP addresses to be protected (used when create_eips is false)"
  type = map(object({
    ip_address = string
    member_uid = string
  }))
  default = {}
}

variable "member_uid" {
  description = "The member to which the asset belongs"
  type        = string
  default     = null
}

variable "create_ddosbgp_policy" {
  description = "Whether to create a DDoS BGP policy"
  type        = bool
  default     = true
}

variable "ddosbgp_policy_name" {
  description = "The name of the DDoS BGP policy"
  type        = string
  default     = "terraform-example-policy"
}

variable "ddosbgp_policy_type" {
  description = "The type of the DDoS BGP policy"
  type        = string
  default     = "l4"
}

variable "common_tags" {
  description = "A mapping of tags to assign to all resources"
  type        = map(string)
  default = {
    Environment = "example"
    Project     = "terraform-ddosbgp-example"
  }
}