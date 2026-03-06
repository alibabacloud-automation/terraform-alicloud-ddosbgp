variable "create_instance" {
  type        = bool
  description = "Whether to create a new DDoS BGP instance. If false, an existing instance ID must be provided."
  default     = true
}

variable "ddosbgp_instance_id" {
  type        = string
  description = "The ID of an existing DDoS BGP instance. Required when create_instance is false."
  default     = null
}

variable "instance_config" {
  type = object({
    instance_name     = optional(string, "terraform-ddosbgp-instance")
    base_bandwidth    = optional(number, 20)
    bandwidth         = number
    ip_count          = number
    ip_type           = optional(string, "IPv4")
    normal_bandwidth  = number
    type              = optional(string, "Enterprise")
    period            = optional(number, 12)
    resource_group_id = optional(string, null)
  })
  description = "The parameters of DDoS BGP instance. The attributes 'bandwidth', 'ip_count', and 'normal_bandwidth' are required."
  default = {
    bandwidth        = null
    ip_count         = null
    normal_bandwidth = null
  }
}

variable "protected_ips_config" {
  type = map(object({
    ip_address = string
    member_uid = optional(string, null)
  }))
  description = "Map of IP addresses to be protected by DDoS BGP. Each IP configuration must include 'ip_address'."
  default     = {}
}

variable "create_policy" {
  type        = bool
  description = "Whether to create a DDoS BGP policy."
  default     = false
}

variable "policy_config" {
  type = object({
    policy_name = string
    type        = optional(string, "l4")
  })
  description = "The parameters of DDoS BGP policy. The attribute 'policy_name' is required."
  default = {
    policy_name = null
  }
}

variable "policy_content" {
  type = object({
    black_ip_list_expire_at     = optional(number, null)
    enable_defense              = optional(string, null)
    enable_drop_icmp            = optional(string, null)
    enable_intelligence         = optional(string, null)
    intelligence_level          = optional(string, null)
    reflect_block_udp_port_list = optional(list(number), null)
    region_block_country_list   = optional(list(string), null)
    region_block_province_list  = optional(list(string), null)
    whiten_gfbr_nets            = optional(string, null)
    finger_print_rule_list = optional(list(object({
      dst_port_end         = number
      dst_port_start       = number
      finger_print_rule_id = optional(string, null)
      match_action         = string
      max_pkt_len          = number
      min_pkt_len          = number
      offset               = optional(number, null)
      payload_bytes        = optional(string, null)
      protocol             = string
      rate_value           = optional(number, null)
      seq_no               = number
      src_port_end         = number
      src_port_start       = number
    })), null)
    layer4_rule_list = optional(list(object({
      action   = string
      limited  = string
      match    = string
      method   = string
      name     = string
      priority = string
      condition_list = list(object({
        arg      = string
        depth    = string
        position = string
      }))
    })), null)
    port_rule_list = optional(list(object({
      dst_port_end   = number
      dst_port_start = number
      match_action   = string
      port_rule_id   = optional(string, null)
      protocol       = string
      seq_no         = number
      src_port_end   = number
      src_port_start = number
    })), null)
    source_block_list = optional(list(object({
      block_expire_seconds = number
      every_seconds        = number
      exceed_limit_times   = number
      type                 = number
    })), null)
    source_limit = optional(object({
      bps     = optional(number, null)
      pps     = optional(number, null)
      syn_bps = optional(number, null)
      syn_pps = optional(number, null)
    }), null)
  })
  description = "Custom DDoS BGP policy content configuration. If not provided, the default L4 policy content will be used."
  default = {
    black_ip_list_expire_at     = null
    enable_defense              = "true"
    enable_drop_icmp            = null
    enable_intelligence         = null
    intelligence_level          = null
    reflect_block_udp_port_list = null
    region_block_country_list   = null
    region_block_province_list  = null
    whiten_gfbr_nets            = null
    finger_print_rule_list      = null
    layer4_rule_list = [
      {
        method  = "hex"
        match   = "1"
        action  = "1"
        limited = "0"
        condition_list = [
          {
            arg      = "3C"
            position = "1"
            depth    = "2"
          }
        ]
        name     = "default_l4_rule"
        priority = "10"
      }
    ]
    port_rule_list    = null
    source_block_list = null
    source_limit      = null
  }
}

variable "tags" {
  type        = map(string)
  description = "A mapping of tags to assign to the DDoS BGP instance."
  default     = {}
}