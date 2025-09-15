# Task A – Create a Terraform-managed AWS VPC
- Create a VPC with public/private subnets, NAT gateway, and internet
gateway.
- Use Terraform modules and variables.
- Output: working .tf files and diagram of architecture.

## Dependencies

Before starting, ensure you have the following installed:

- **Terraform**:  
  [Download and install Terraform](https://developer.hashicorp.com/terraform/tutorials/aws-get-started/install-cli) (version 1.0 or higher recommended).

- **AWS CLI** (optional, for authentication):  
  [Install AWS CLI](https://docs.aws.amazon.com/cli/latest/userguide/getting-started-install.html)

- **AWS credentials**:  
  Configure your AWS credentials using `aws configure` or by setting environment variables.

## Running the Infrastructure

### AWS Credentials Setup

Before running Terraform, ensure your AWS credentials are configured. You have several options:

1. **AWS CLI configuration** (recommended):
   ```bash
   aws configure
   ```
   This will prompt you for:
   - AWS Access Key ID
   - AWS Secret Access Key
   - Default region name (e.g., `us-east-1`)
   - Default output format (e.g., `json`)

2. **Environment variables**:
   ```bash
   export AWS_ACCESS_KEY_ID="your-access-key"
   export AWS_SECRET_ACCESS_KEY="your-secret-key"
   export AWS_DEFAULT_REGION="us-east-1"
   ```

3. **IAM roles** (if running on EC2):
   Attach an IAM role with appropriate permissions to your EC2 instance.

### Terraform Commands

Navigate to the terraform directory and run the following commands:

```bash
cd terraform

# Initialize Terraform (downloads providers and modules)
terraform init

# Plan the infrastructure changes
terraform plan

# Apply the infrastructure changes
terraform apply

# To destroy the infrastructure when done
terraform destroy
```

### Required Permissions

Your AWS credentials need the following permissions:
- VPC creation and management
- Subnet creation and management
- Internet Gateway and NAT Gateway management
- Route table management
- Security group management

### Module Structure

This project uses a modular approach:
- `aws_vpc` module: Creates VPC, calculates subnet CIDRs, and orchestrates AZ networks
- `aws_az_pub_priv_network` module: Creates public/private subnets, NAT gateway, and routing for a single AZ

