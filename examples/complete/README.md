# Complete Example

This example demonstrates how to use the terraform-alicloud-ddosbgp module to create a complete DDoS BGP protection setup.

## Features

This example creates:

- A DDoS BGP instance with configurable bandwidth and IP protection capacity
- EIP addresses that will be protected by the DDoS BGP instance
- A DDoS BGP policy with L4 protection rules
- Protected IP configurations linking the EIPs to the DDoS BGP instance

## Usage

To run this example you need to execute:

```bash
$ terraform init
$ terraform plan
$ terraform apply
```

Note that this example may create resources which cost money. Run `terraform destroy` when you don't need these resources.

## Requirements

| Name | Version |
|------|---------|
| terraform | >= 1.0 |
| alicloud | >= 1.226.0 |

## Providers

| Name | Version |
|------|---------|
| alicloud | >= 1.226.0 |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| region | The region where resources will be created | `string` | `"cn-hangzhou"` | no |
| create_ddosbgp_instance | Whether to create a new DDoS BGP instance | `bool` | `true` | no |
| ddosbgp_instance_name | The name of the DDoS BGP instance | `string` | `"terraform-example-ddosbgp"` | no |
| ddosbgp_bandwidth | The bandwidth of the DDoS BGP instance | `number` | `-1` | no |
| ddosbgp_ip_count | The number of IP addresses that can be protected | `number` | `100` | no |
| ddosbgp_normal_bandwidth | The normal clean bandwidth | `number` | `100` | no |
| create_eips | Whether to create EIP addresses for DDoS BGP protection | `bool` | `true` | no |
| protected_ip_names | List of names for protected IP addresses | `list(string)` | `["terraform-example-eip-1", "terraform-example-eip-2"]` | no |
| create_ddosbgp_policy | Whether to create a DDoS BGP policy | `bool` | `true` | no |
| ddosbgp_policy_name | The name of the DDoS BGP policy | `string` | `"terraform-example-policy"` | no |

## Outputs

| Name | Description |
|------|-------------|
| ddosbgp_instance_id | The ID of the DDoS BGP instance |
| ddosbgp_instance_status | The status of the DDoS BGP instance |
| protected_ips | Map of protected IP addresses and their configurations |
| protected_ip_addresses | List of protected IP addresses |
| ddosbgp_policy_id | The ID of the DDoS BGP policy |
| module_summary | Summary of all DDoS BGP resources created by this module |

## Example Configuration

### Basic Usage

```hcl
module "ddosbgp" {
  source = "../../"

  create_instance = true
  instance_config = {
    instance_name     = "my-ddosbgp-instance"
    bandwidth         = -1
    ip_count          = 50
    normal_bandwidth  = 100
  }

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

### Using Existing DDoS BGP Instance

```hcl
module "ddosbgp" {
  source = "../../"

  create_instance     = false
  ddosbgp_instance_id = "ddosbgp-cn-xxxxxxxxx"

  protected_ips_config = {
    "existing-server" = {
      ip_address = "1.2.3.6"
      member_uid = null
    }
  }

  create_policy = false
}
```

## Notes

- The DDoS BGP instance creation may take several minutes to complete
- Ensure you have sufficient quota for DDoS BGP instances in your region
- The bandwidth parameter `-1` means unlimited bandwidth (pay-as-you-go)
- EIP addresses must be in the same region as the DDoS BGP instance
- You can protect both new and existing IP addresses with this module