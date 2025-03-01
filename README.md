# Azure Sentinel Terraform Module

<!-- Add logo when available -->
<!-- ![RedDome Logo](./assets/reddome-logo.png) -->

## Overview

This Terraform module deploys Microsoft Sentinel (formerly Azure Sentinel) and its dependencies. It's maintained by [RedDome](https://reddome.org) for educational purposes and professional implementations.

## Prerequisites

- [Terraform](https://www.terraform.io/downloads.html) (>= 1.0.0)
- Azure Subscription
- Terraform Cloud account
- GitHub account
- Cloudflare account (for DNS management)

## Quick Start

1. Fork this repository to your GitHub account

2. Set up Terraform Cloud:
   ```bash
   # Login to Terraform Cloud
   terraform login
   
   # Create a new workspace in Terraform Cloud
   # Choose "Version control workflow" and connect to your forked repository
   ```

3. Configure Variables in Terraform Cloud:
   - Add the following variables:
     ```hcl
     resource_group_name = "rg-sentinel-prod"
     workspace_name     = "law-sentinel-prod"
     ```

4. Configure Azure Credentials:
   - Add these as environment variables in Terraform Cloud:
     ```
     ARM_CLIENT_ID
     ARM_CLIENT_SECRET
     ARM_SUBSCRIPTION_ID
     ARM_TENANT_ID
     ```

5. Configure Cloudflare (Optional):
   - Add your Cloudflare API token as an environment variable:
     ```
     CLOUDFLARE_API_TOKEN
     ```

## Usage

```hcl
module "sentinel" {
  source  = "github.com/reddomeuk/terraform-azure-sentinel"
  
  resource_group_name = "rg-sentinel-prod"
  workspace_name     = "law-sentinel-prod"
  location           = "eastus"
  
  tags = {
    environment = "production"
    managed_by  = "terraform"
  }
}
```

## Variables

| Name | Description | Type | Default |
|------|-------------|------|---------|
| resource_group_name | Name of the resource group | string | - |
| workspace_name | Name of the Log Analytics workspace | string | - |
| location | Azure region | string | "eastus" |
| tags | Resource tags | map(string) | {} |

## Contributing

Contributions are welcome! Please read our [Contributing Guidelines](CONTRIBUTING.md).

## Support

For support and queries:
- Visit [RedDome.org](https://reddome.org)
- Create an issue in this repository
- Contact: info@reddome.org

## Maintainer

- [RedDomeUK](https://github.com/reddomeuk)

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.
