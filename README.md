# Konecta AWS DRIVE 
# AWS Infrastructure as Code Project

This project manages AWS infrastructure using Terraform, implementing a multi-module approach to handle various AWS services including VPC, IAM, S3, and CloudWatch Alarms.

## Project Structure

```
.
├── main.tf              # Main Terraform configuration
├── vars.tf             # Root variables definition
├── vars.auto.tfvars    # Variable values
└── modules/
    ├── cloudwatch-alarms/  # CloudWatch Alarms configuration
          import.sh
          alarms.tf
          vars.tf
          outputs.tf
    ├── iam/               # IAM roles and policies
          import.sh
          iam.tf
          vars.tf
          outputs.tf
    ├── s3/               # S3 buckets configuration
          import.sh
          s3.tf
          vars.tf
          outputs.tf
    └── vpc/              # VPC networking components
          import.sh
          vpc.tf
          vars.tf
          outputs.tf
```

## Modules

### VPC Module
- Creates and manages VPC resources in the SA-EAST-1 region
- Supports multiple subnets with customizable CIDR blocks
- Handles route tables and internet gateways
- Includes import functionality for existing resources

### IAM Module
- Manages IAM roles with trust relationships
- Supports automatic policy document importing
- Handles role tags for QuickSetup resources
- Limited to first 10 roles for manageability

### S3 Module
- Creates and manages S3 buckets across regions
- Supports custom tagging based on bucket purpose
- Handles both default and specific bucket configurations
- Includes separate configuration for US-EAST-1 region

### CloudWatch Alarms Module
- Configures metric alarms with customizable parameters
- Supports various alarm configurations and thresholds
- Includes import functionality for existing alarms

## Prerequisites

- AWS CLI configured with appropriate credentials
- Terraform ~> 1.0
- AWS provider ~> 6.0

## Usage

1. Initialize Terraform:
```bash
terraform init
```

2. Import existing resources (optional):
```bash
# For VPC resources
./modules/vpc/import.sh

# For IAM roles
./modules/iam/import.sh

# For S3 buckets
./modules/s3/import.sh

# For CloudWatch alarms
./modules/cloudwatch-alarms/import.sh
```

3. Plan and apply changes:
```bash
terraform plan
terraform apply
```

## Variables

The project uses various variables defined in `vars.tf`. Key variables include:

- `region`: AWS region for resource deployment
- `vpc_cidr`: CIDR block for VPC
- `bucket_names`: List of S3 bucket names
- `iam_roles`: Set of IAM role names
- `cloudwatch_alarms`: Map of CloudWatch alarm configurations

## Provider Configuration

The project uses multiple provider configurations:
- Default region (defined by `var.region`)
- US-EAST-1 for specific S3 buckets
- SA-EAST-1 for VPC resources

## Tags

Resources are tagged according to the following scheme:
- Country
- Platform
- Project
- Special tags for QuickSetup resources

## Notes

- The project includes automatic importing of existing resources
- Some modules have limitations on the number of resources they manage
- Sensitive files are excluded via .gitignore
