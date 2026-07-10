**Here's a clean, professional `README.md`** you can use with the Terraform project:

---

# OCI Always Free Ampere A1 Terraform

This Terraform configuration deploys a **free-tier eligible** Ubuntu 24.04 instance on **Ampere A1 Flex** (Arm processor) with a complete networking setup.

## Features

- **VM.Standard.A1.Flex** instance (4 OCPU / 24 GB RAM)
- Ubuntu 24.04 LTS
- Full VCN with public subnet
- Internet Gateway + proper routing
- Security List (SSH access + outbound traffic)
- Automatic SSH key injection
- Cloud-init basic setup

## Prerequisites

- Oracle Cloud account (Always Free or Pay-As-You-Go)
- [Terraform](https://www.terraform.io/downloads) installed
- OCI CLI configured **or** valid OCI credentials
- SSH key pair (`~/.ssh/id_rsa.pub`)

> **Note**: As of mid-2026, the Always Free limit for Ampere A1 is **2 OCPU / 12 GB**. The 4/24 configuration may incur charges or fail due to capacity. Reduce resources if needed.

## Quick Start

### 1. Clone or create project folder

```bash
mkdir oci-ampere-a1 && cd oci-ampere-a1
```

### 2. Create the files

Create the following files:
- `main.tf`
- `variables.tf`
- `terraform.tfvars` (for your secrets)

### 3. Configure variables (`terraform.tfvars`)

```hcl
compartment_ocid = "ocid1.compartment.oc1..xxxxxxxxxxxxxxxx"
tenancy_ocid     = "ocid1.tenancy.oc1..xxxxxxxxxxxxxxxx"
ssh_public_key   = "~/.ssh/id_rsa.pub"   # or your custom key
```

### 4. Deploy

```bash
terraform init
terraform plan
terraform apply -auto-approve
```

### 5. Connect to the instance

After deployment, Terraform will output the public IP:

```bash
ssh ubuntu@<PUBLIC_IP>
```

## Project Structure

```
.
├── main.tf
├── variables.tf
├── terraform.tfvars
└── README.md
```

## Resources Created

- 1 Virtual Cloud Network (VCN)
- 1 Internet Gateway
- 1 Public Route Table
- 1 Security List (SSH port 22 open)
- 1 Public Subnet
- 1 Ampere A1 Compute Instance

## Customization

- Change `ocpus` and `memory_in_gbs` in `main.tf` to stay within free tier limits.
- Modify Security List rules for additional ports (e.g., 80, 443).
- Increase boot volume size (max ~47-50 GB in free tier).

## Destroy Resources

```bash
terraform destroy
```

## Important Notes

- Always Free resources have limits. Monitor usage in OCI Console.
- Instance may take 2–5 minutes to become accessible after creation.
- For production use, consider adding a Block Volume, backups, and tighter security groups.

---

Would you like me to also add:
- A version with private subnet + bastion?
- Cloud-init for Docker / specific setup?
- Cost warning section?

Just say the word and I’ll update it!