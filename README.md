# AWS Infrastructure Provisioning with Terraform

This project uses **Terraform** to provision a highly available infrastructure on **AWS**, including a VPC, public/private subnets, and EC2 instances.

## 🏗️ Architecture
*Briefly describe the architecture or include an image link here.*
- **Networking:** Custom VPC with 3-tier subnet architecture.
- **Compute:** Auto Scaling Group (ASG) behind an Application Load Balancer (ALB).
- **Security:** IAM roles with least-privilege and managed Security Groups.

## 📋 Prerequisites
Before you begin, ensure you have the following:
- [Terraform CLI](https://hashicorp.com) (v1.0+) installed.
- [AWS CLI](https://amazon.com) configured with appropriate credentials.
- An S3 bucket and DynamoDB table for **Remote State Management** (optional but recommended).

## 🚀 Getting Started

1. **Clone the repository:**
   ```bash
   git clone <your-repo-url>
   cd <project-directory>
   ```

2. **Initialize Terraform:**
   This command installs the [AWS Provider](https://terraform.io) and initializes the backend.
   ```bash
   terraform init
   ```

3. **View the execution plan:**
   Verify the resources that will be created.
   ```bash
   terraform plan -var-file="terraform.tfvars"
   ```

4. **Apply changes:**
   Deploy the infrastructure to AWS.
   ```bash
   terraform apply -var-file="terraform.tfvars" -auto-approve
   ```

## ⚙️ Configuration

### Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| `aws_region` | The AWS region to deploy resources | `string` | `us-east-1` | yes |
| `instance_type` | EC2 instance size | `string` | `t3.micro` | no |

### Outputs

| Name | Description |
|------|-------------|
| `vpc_id` | The ID of the created VPC |
| `alb_dns_name` | The public DNS name of the Load Balancer |

## 🧹 Cleanup
To avoid ongoing AWS charges, destroy the resources when finished:
```bash
terraform destroy -auto-approve
```
