# terraform-alicloud-ddosbgp

[English](https://github.com/alibabacloud-automation/terraform-alicloud-ddosbgp/blob/main/README.md) | 简体中文

用于在阿里云上创建Anti-DDoS Pro (DdosBgp)资源的Terraform模块。该模块通过创建DDoS BGP实例、管理受保护IP地址和配置安全策略，为您的云基础设施提供全面的DDoS防护。该模块支持灵活的配置选项，适用于不同的防护场景，从基础DDoS缓解到高级L4/L7防护规则。

## 使用方法

该模块允许您创建和管理DDoS BGP防护资源，包括实例、受保护IP地址和安全策略。您可以使用它来保护您的Web应用程序、API和其他面向互联网的服务免受DDoS攻击。

```terraform
module "ddosbgp" {
  source  = "alibabacloud-automation/ddosbgp/alicloud"

  # DDoS BGP实例配置
  instance_config = {
    bandwidth         = -1
    ip_count          = 50
    normal_bandwidth  = 100
  }

  # 受保护IP地址
  protected_ips_config = {
    "web-server" = {
      ip_address = "1.2.3.4"
    }
    "api-server" = {
      ip_address = "1.2.3.5"
    }
  }

  # DDoS防护策略
  create_policy = true
  policy_config = {
    policy_name = "my-l4-policy"
  }
}
```

## 示例

* [完整示例](https://github.com/alibabacloud-automation/terraform-alicloud-ddosbgp/tree/main/examples/complete)

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.0 |
| <a name="requirement_alicloud"></a> [alicloud](#requirement\_alicloud) | >= 1.226.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_alicloud"></a> [alicloud](#provider\_alicloud) | >= 1.226.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [alicloud_ddos_bgp_policy.policy](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/ddos_bgp_policy) | resource |
| [alicloud_ddosbgp_instance.instance](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/ddosbgp_instance) | resource |
| [alicloud_ddosbgp_ip.protected_ips](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/ddosbgp_ip) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_create_instance"></a> [create\_instance](#input\_create\_instance) | Whether to create a new DDoS BGP instance. If false, an existing instance ID must be provided. | `bool` | `true` | no |
| <a name="input_create_policy"></a> [create\_policy](#input\_create\_policy) | Whether to create a DDoS BGP policy. | `bool` | `false` | no |
| <a name="input_ddosbgp_instance_id"></a> [ddosbgp\_instance\_id](#input\_ddosbgp\_instance\_id) | The ID of an existing DDoS BGP instance. Required when create\_instance is false. | `string` | `null` | no |
| <a name="input_instance_config"></a> [instance\_config](#input\_instance\_config) | The parameters of DDoS BGP instance. The attributes 'bandwidth', 'ip\_count', and 'normal\_bandwidth' are required. | <pre>object({<br/>    instance_name     = optional(string, "terraform-ddosbgp-instance")<br/>    base_bandwidth    = optional(number, 20)<br/>    bandwidth         = number<br/>    ip_count          = number<br/>    ip_type           = optional(string, "IPv4")<br/>    normal_bandwidth  = number<br/>    type              = optional(string, "Enterprise")<br/>    period            = optional(number, 12)<br/>    resource_group_id = optional(string, null)<br/>  })</pre> | <pre>{<br/>  "bandwidth": null,<br/>  "ip_count": null,<br/>  "normal_bandwidth": null<br/>}</pre> | no |
| <a name="input_policy_config"></a> [policy\_config](#input\_policy\_config) | The parameters of DDoS BGP policy. The attribute 'policy\_name' is required. | <pre>object({<br/>    policy_name = string<br/>    type        = optional(string, "l4")<br/>  })</pre> | <pre>{<br/>  "policy_name": null<br/>}</pre> | no |
| <a name="input_policy_content"></a> [policy\_content](#input\_policy\_content) | Custom DDoS BGP policy content configuration. If not provided, the default L4 policy content will be used. | <pre>object({<br/>    black_ip_list_expire_at     = optional(number, null)<br/>    enable_defense              = optional(string, null)<br/>    enable_drop_icmp            = optional(string, null)<br/>    enable_intelligence         = optional(string, null)<br/>    intelligence_level          = optional(string, null)<br/>    reflect_block_udp_port_list = optional(list(number), null)<br/>    region_block_country_list   = optional(list(string), null)<br/>    region_block_province_list  = optional(list(string), null)<br/>    whiten_gfbr_nets            = optional(string, null)<br/>    finger_print_rule_list = optional(list(object({<br/>      dst_port_end         = number<br/>      dst_port_start       = number<br/>      finger_print_rule_id = optional(string, null)<br/>      match_action         = string<br/>      max_pkt_len          = number<br/>      min_pkt_len          = number<br/>      offset               = optional(number, null)<br/>      payload_bytes        = optional(string, null)<br/>      protocol             = string<br/>      rate_value           = optional(number, null)<br/>      seq_no               = number<br/>      src_port_end         = number<br/>      src_port_start       = number<br/>    })), null)<br/>    layer4_rule_list = optional(list(object({<br/>      action   = string<br/>      limited  = string<br/>      match    = string<br/>      method   = string<br/>      name     = string<br/>      priority = string<br/>      condition_list = list(object({<br/>        arg      = string<br/>        depth    = string<br/>        position = string<br/>      }))<br/>    })), null)<br/>    port_rule_list = optional(list(object({<br/>      dst_port_end   = number<br/>      dst_port_start = number<br/>      match_action   = string<br/>      port_rule_id   = optional(string, null)<br/>      protocol       = string<br/>      seq_no         = number<br/>      src_port_end   = number<br/>      src_port_start = number<br/>    })), null)<br/>    source_block_list = optional(list(object({<br/>      block_expire_seconds = number<br/>      every_seconds        = number<br/>      exceed_limit_times   = number<br/>      type                 = number<br/>    })), null)<br/>    source_limit = optional(object({<br/>      bps     = optional(number, null)<br/>      pps     = optional(number, null)<br/>      syn_bps = optional(number, null)<br/>      syn_pps = optional(number, null)<br/>    }), null)<br/>  })</pre> | <pre>{<br/>  "black_ip_list_expire_at": null,<br/>  "enable_defense": "true",<br/>  "enable_drop_icmp": null,<br/>  "enable_intelligence": null,<br/>  "finger_print_rule_list": null,<br/>  "intelligence_level": null,<br/>  "layer4_rule_list": [<br/>    {<br/>      "action": "1",<br/>      "condition_list": [<br/>        {<br/>          "arg": "3C",<br/>          "depth": "2",<br/>          "position": "1"<br/>        }<br/>      ],<br/>      "limited": "0",<br/>      "match": "1",<br/>      "method": "hex",<br/>      "name": "default_l4_rule",<br/>      "priority": "10"<br/>    }<br/>  ],<br/>  "port_rule_list": null,<br/>  "reflect_block_udp_port_list": null,<br/>  "region_block_country_list": null,<br/>  "region_block_province_list": null,<br/>  "source_block_list": null,<br/>  "source_limit": null,<br/>  "whiten_gfbr_nets": null<br/>}</pre> | no |
| <a name="input_protected_ips_config"></a> [protected\_ips\_config](#input\_protected\_ips\_config) | Map of IP addresses to be protected by DDoS BGP. Each IP configuration must include 'ip\_address'. | <pre>map(object({<br/>    ip_address = string<br/>    member_uid = optional(string, null)<br/>  }))</pre> | `{}` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | A mapping of tags to assign to the DDoS BGP instance. | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_ddosbgp_instance_bandwidth"></a> [ddosbgp\_instance\_bandwidth](#output\_ddosbgp\_instance\_bandwidth) | The bandwidth of the DDoS BGP instance |
| <a name="output_ddosbgp_instance_base_bandwidth"></a> [ddosbgp\_instance\_base\_bandwidth](#output\_ddosbgp\_instance\_base\_bandwidth) | The base bandwidth of the DDoS BGP instance |
| <a name="output_ddosbgp_instance_id"></a> [ddosbgp\_instance\_id](#output\_ddosbgp\_instance\_id) | The ID of the DDoS BGP instance |
| <a name="output_ddosbgp_instance_ip_count"></a> [ddosbgp\_instance\_ip\_count](#output\_ddosbgp\_instance\_ip\_count) | The IP count of the DDoS BGP instance |
| <a name="output_ddosbgp_instance_ip_type"></a> [ddosbgp\_instance\_ip\_type](#output\_ddosbgp\_instance\_ip\_type) | The IP type of the DDoS BGP instance |
| <a name="output_ddosbgp_instance_name"></a> [ddosbgp\_instance\_name](#output\_ddosbgp\_instance\_name) | The name of the DDoS BGP instance |
| <a name="output_ddosbgp_instance_normal_bandwidth"></a> [ddosbgp\_instance\_normal\_bandwidth](#output\_ddosbgp\_instance\_normal\_bandwidth) | The normal bandwidth of the DDoS BGP instance |
| <a name="output_ddosbgp_instance_status"></a> [ddosbgp\_instance\_status](#output\_ddosbgp\_instance\_status) | The status of the DDoS BGP instance |
| <a name="output_ddosbgp_instance_type"></a> [ddosbgp\_instance\_type](#output\_ddosbgp\_instance\_type) | The type of the DDoS BGP instance |
| <a name="output_ddosbgp_policy_id"></a> [ddosbgp\_policy\_id](#output\_ddosbgp\_policy\_id) | The ID of the DDoS BGP policy |
| <a name="output_ddosbgp_policy_name"></a> [ddosbgp\_policy\_name](#output\_ddosbgp\_policy\_name) | The name of the DDoS BGP policy |
| <a name="output_ddosbgp_policy_type"></a> [ddosbgp\_policy\_type](#output\_ddosbgp\_policy\_type) | The type of the DDoS BGP policy |
| <a name="output_module_summary"></a> [module\_summary](#output\_module\_summary) | Summary of all DDoS BGP resources created by this module |
| <a name="output_protected_ip_addresses"></a> [protected\_ip\_addresses](#output\_protected\_ip\_addresses) | List of protected IP addresses |
| <a name="output_protected_ip_ids"></a> [protected\_ip\_ids](#output\_protected\_ip\_ids) | List of protected IP resource IDs |
| <a name="output_protected_ips"></a> [protected\_ips](#output\_protected\_ips) | Map of protected IP addresses and their configurations |
<!-- END_TF_DOCS -->

## 提交问题

如果您在使用此模块时遇到任何问题，请提交一个 [provider issue](https://github.com/aliyun/terraform-provider-alicloud/issues/new) 并告知我们。

**注意：** 不建议在此仓库中提交问题。

## 作者

由阿里云 Terraform 团队创建和维护(terraform@alibabacloud.com)。

## 许可证

MIT 许可。有关完整详细信息，请参阅 LICENSE。

## 参考

* [Terraform-Provider-Alicloud Github](https://github.com/aliyun/terraform-provider-alicloud)
* [Terraform-Provider-Alicloud Release](https://releases.hashicorp.com/terraform-provider-alicloud/)
* [Terraform-Provider-Alicloud Docs](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs)