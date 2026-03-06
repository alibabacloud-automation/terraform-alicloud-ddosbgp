# Locals block for complex logic and calculations
locals {
  # Get the DDoS BGP instance ID - either from newly created instance or external input
  this_ddosbgp_instance_id = var.create_instance ? alicloud_ddosbgp_instance.instance[0].id : var.ddosbgp_instance_id
}

# DDoS BGP Instance resource (optional creation)
resource "alicloud_ddosbgp_instance" "instance" {
  count             = var.create_instance ? 1 : 0
  instance_name     = var.instance_config.instance_name
  base_bandwidth    = var.instance_config.base_bandwidth
  bandwidth         = var.instance_config.bandwidth
  ip_count          = var.instance_config.ip_count
  ip_type           = var.instance_config.ip_type
  normal_bandwidth  = var.instance_config.normal_bandwidth
  type              = var.instance_config.type
  period            = var.instance_config.period
  resource_group_id = var.instance_config.resource_group_id
  tags              = var.tags
}

# Protected IP addresses (multiple IPs supported via for_each)
resource "alicloud_ddosbgp_ip" "protected_ips" {
  for_each    = var.protected_ips_config
  instance_id = local.this_ddosbgp_instance_id
  ip          = each.value.ip_address
  member_uid  = each.value.member_uid
}

# DDoS BGP Policy resource (optional creation)
resource "alicloud_ddos_bgp_policy" "policy" {
  count       = var.create_policy ? 1 : 0
  policy_name = var.policy_config.policy_name
  type        = var.policy_config.type

  dynamic "content" {
    for_each = [var.policy_content]
    content {
      black_ip_list_expire_at     = content.value.black_ip_list_expire_at
      enable_defense              = content.value.enable_defense
      enable_drop_icmp            = content.value.enable_drop_icmp
      enable_intelligence         = content.value.enable_intelligence
      intelligence_level          = content.value.intelligence_level
      reflect_block_udp_port_list = content.value.reflect_block_udp_port_list
      region_block_country_list   = content.value.region_block_country_list
      region_block_province_list  = content.value.region_block_province_list
      whiten_gfbr_nets            = content.value.whiten_gfbr_nets

      dynamic "finger_print_rule_list" {
        for_each = content.value.finger_print_rule_list != null ? content.value.finger_print_rule_list : []
        content {
          dst_port_end         = finger_print_rule_list.value.dst_port_end
          dst_port_start       = finger_print_rule_list.value.dst_port_start
          finger_print_rule_id = finger_print_rule_list.value.finger_print_rule_id
          match_action         = finger_print_rule_list.value.match_action
          max_pkt_len          = finger_print_rule_list.value.max_pkt_len
          min_pkt_len          = finger_print_rule_list.value.min_pkt_len
          offset               = finger_print_rule_list.value.offset
          payload_bytes        = finger_print_rule_list.value.payload_bytes
          protocol             = finger_print_rule_list.value.protocol
          rate_value           = finger_print_rule_list.value.rate_value
          seq_no               = finger_print_rule_list.value.seq_no
          src_port_end         = finger_print_rule_list.value.src_port_end
          src_port_start       = finger_print_rule_list.value.src_port_start
        }
      }

      dynamic "layer4_rule_list" {
        for_each = content.value.layer4_rule_list != null ? content.value.layer4_rule_list : []
        content {
          action   = layer4_rule_list.value.action
          limited  = layer4_rule_list.value.limited
          match    = layer4_rule_list.value.match
          method   = layer4_rule_list.value.method
          name     = layer4_rule_list.value.name
          priority = layer4_rule_list.value.priority

          dynamic "condition_list" {
            for_each = layer4_rule_list.value.condition_list != null ? layer4_rule_list.value.condition_list : []
            content {
              arg      = condition_list.value.arg
              depth    = condition_list.value.depth
              position = condition_list.value.position
            }
          }
        }
      }

      dynamic "port_rule_list" {
        for_each = content.value.port_rule_list != null ? content.value.port_rule_list : []
        content {
          dst_port_end   = port_rule_list.value.dst_port_end
          dst_port_start = port_rule_list.value.dst_port_start
          match_action   = port_rule_list.value.match_action
          port_rule_id   = port_rule_list.value.port_rule_id
          protocol       = port_rule_list.value.protocol
          seq_no         = port_rule_list.value.seq_no
          src_port_end   = port_rule_list.value.src_port_end
          src_port_start = port_rule_list.value.src_port_start
        }
      }

      dynamic "source_block_list" {
        for_each = content.value.source_block_list != null ? content.value.source_block_list : []
        content {
          block_expire_seconds = source_block_list.value.block_expire_seconds
          every_seconds        = source_block_list.value.every_seconds
          exceed_limit_times   = source_block_list.value.exceed_limit_times
          type                 = source_block_list.value.type
        }
      }

      dynamic "source_limit" {
        for_each = content.value.source_limit != null ? [content.value.source_limit] : []
        content {
          bps     = source_limit.value.bps
          pps     = source_limit.value.pps
          syn_bps = source_limit.value.syn_bps
          syn_pps = source_limit.value.syn_pps
        }
      }
    }
  }
}