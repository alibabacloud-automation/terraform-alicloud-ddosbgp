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


## Example Configuration

### Basic Usage

```hcl
module "ddosbgp" {
  source = "../../"

  instance_config = {
    bandwidth         = -1
    ip_count          = 50
    normal_bandwidth  = 100
  }

  protected_ips_config = {
    "web-server" = {
      ip_address = "1.2.3.4"
    }
    "api-server" = {
      ip_address = "1.2.3.5"
    }
  }

  create_policy = true
  policy_config = {
    policy_name = "my-l4-policy"
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