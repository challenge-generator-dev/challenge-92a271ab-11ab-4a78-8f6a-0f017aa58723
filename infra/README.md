# Terraform Infrastructure Module

## Overview
This module provisions AWS infrastructure using Terraform. It includes:
- VPC with public/private subnets
- EC2 instances
- RDS database
- Network security groups and routing

## Prerequisites
- Terraform 1.9.0
- AWS CLI configured with credentials
- AWS account with permissions for VPC, EC2, and RDS

## Directory Structure
```
.
├── environments/          # Environment-specific configurations
│   └── dev/               # Development environment
│       ├── main.tf        # Root module for dev
│       └── terraform.tfvars
├── modules/               # Reusable infrastructure modules
│   ├── compute/           # EC2 instances
│   ├── database/          # RDS instances
│   └── network/           # VPC/networking
├── tests/                 # Acceptance tests
│   └── acceptance/
│       └── f1.tftest.hcl
├── backend.tf             # Remote state configuration
├── outputs.tf             # Output values
├── providers.tf           # Provider configurations
├── variables.tf           # Input variables
└── versions.tf            # Terraform version constraints
```

## Setup
1. Initialize Terraform:
   ```bash
   terraform init
   ```

2. Plan infrastructure changes:
   ```bash
   terraform plan -var-file=environments/dev/terraform.tfvars
   ```

3. Apply infrastructure changes:
   ```bash
   terraform apply -var-file=environments/dev/terraform.tfvars
   ```

## Testing
Run acceptance tests:
```bash
terraform test
```

## Outputs
After applying, Terraform will output:
- VPC ID
- EC2 instance public IPs
- RDS endpoint
- Security group IDs

## Notes
- All resources are tagged with environment (dev/prod)
- The VPC uses 10.0.0.0/16 CIDR block
- EC2 instances use Amazon Linux 2 AMI