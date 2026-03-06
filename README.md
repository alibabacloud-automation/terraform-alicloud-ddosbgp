Alicloud Anti-DDoS Pro (DdosBgp) Terraform Module

# terraform-alicloud-ddosbgp

English | [简体中文](https://github.com/alibabacloud-automation/terraform-alicloud-ddosbgp/blob/main/README-CN.md)

Terraform module which creates Anti-DDoS Pro (DdosBgp) resources on Alibaba Cloud. This module provides comprehensive DDoS protection for your cloud infrastructure by creating DDoS BGP instances, managing protected IP addresses, and configuring security policies. The module supports flexible configuration options for different protection scenarios, from basic DDoS mitigation to advanced L4/L7 protection rules. For more information about Anti-DDoS Pro solutions, please refer to [Anti-DDoS Pro Documentation](https://www.alibabacloud.com/help/en/anti-ddos/anti-ddos-pro).

## Usage

This module allows you to create and manage DDoS BGP protection resources including instances, protected IP addresses, and security policies. You can use it to protect your web applications, APIs, and other internet-facing services from DDoS attacks.

```terraform
module "ddosbgp" {
  source  = "alibabacloud-automation/ddosbgp/alicloud"
  
  # DDoS BGP Instance Configuration
  create_instance = true
  instance_config = {
    instance_name     = "my-ddosbgp-instance"
    bandwidth         = -1
    ip_count          = 50
    normal_bandwidth  = 100
    type              = "Enterprise"
  }

  # Protected IP Addresses
  protected_ips_config = {
    "web-server" = {
      ip_address = "1.2.3.4"
      member_uid = null
    }
    "api-server" = {
      ip_address = "1.2.3.5"
      member_uid = null
    }
  }

  # DDoS Protection Policy
  create_policy = true
  policy_config = {
    policy_name = "my-l4-policy"
    type        = "l4"
  }

  tags = {
    Environment = "production"
    Project     = "web-application"
  }
}
```

## Examples

* [Complete Example](https://github.com/alibabacloud-automation/terraform-alicloud-ddosbgp/tree/main/examples/complete)

<!-- BEGIN_TF_DOCS -->
<!-- END_TF_DOCS -->

## Submit Issues

If you have any problems when using this module, please opening
a [provider issue](https://github.com/aliyun/terraform-provider-alicloud/issues/new) and let us know.

**Note:** There does not recommend opening an issue on this repo.

## Authors

Created and maintained by Alibaba Cloud Terraform Team(terraform@alibabacloud.com).

## License

MIT Licensed. See LICENSE for full details.

## Reference

* [Terraform-Provider-Alicloud Github](https://github.com/aliyun/terraform-provider-alicloud)
* [Terraform-Provider-Alicloud Release](https://releases.hashicorp.com/terraform-provider-alicloud/)
* [Terraform-Provider-Alicloud Docs](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs)