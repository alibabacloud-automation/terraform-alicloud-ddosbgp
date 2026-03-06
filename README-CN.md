阿里云Anti-DDoS Pro (DdosBgp) Terraform模块

# terraform-alicloud-ddosbgp

[English](https://github.com/alibabacloud-automation/terraform-alicloud-ddosbgp/blob/main/README.md) | 简体中文

用于在阿里云上创建Anti-DDoS Pro (DdosBgp)资源的Terraform模块。该模块通过创建DDoS BGP实例、管理受保护IP地址和配置安全策略，为您的云基础设施提供全面的DDoS防护。该模块支持灵活的配置选项，适用于不同的防护场景，从基础DDoS缓解到高级L4/L7防护规则。有关Anti-DDoS Pro解决方案的更多信息，请参考[Anti-DDoS Pro文档](https://www.alibabacloud.com/help/en/anti-ddos/anti-ddos-pro)。

## 使用方法

该模块允许您创建和管理DDoS BGP防护资源，包括实例、受保护IP地址和安全策略。您可以使用它来保护您的Web应用程序、API和其他面向互联网的服务免受DDoS攻击。

```terraform
module "ddosbgp" {
  source  = "alibabacloud-automation/ddosbgp/alicloud"
  
  # DDoS BGP实例配置
  create_instance = true
  instance_config = {
    instance_name     = "my-ddosbgp-instance"
    bandwidth         = -1
    ip_count          = 50
    normal_bandwidth  = 100
    type              = "Enterprise"
  }

  # 受保护IP地址
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

  # DDoS防护策略
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

## 示例

* [完整示例](https://github.com/alibabacloud-automation/terraform-alicloud-ddosbgp/tree/main/examples/complete)

<!-- BEGIN_TF_DOCS -->
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