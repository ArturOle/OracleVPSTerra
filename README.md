# OCI Ampere A1 Secure Terraform

Terraform configuration to deploy an **Ubuntu 24.04** instance on **Ampere A1 Flex** in Oracle Cloud (Always Free eligible).

## Features

- **Ampere A1 Flex** (4 OCPU / 24 GB)
- Ubuntu 24.04 LTS
- Full VCN + Public Subnet setup
- SSH restricted to your allowed IPs only
- Hardened SSH configuration (no password login)
- `fail2ban` + `ufw` firewall
- Automatic security updates on boot

## Security Highlights

- SSH access limited to specific IPs (`allowed_ssh_ips`)
- Password authentication disabled
- Brute-force protection with Fail2Ban
- Strict firewall rules
- Root login disabled

## Project Structure

```
.
├── main.tf
├── providers.tf
├── versions.tf
├── variables.tf
├── outputs.tf
├── network.tf
├── compute.tf
├── terraform.tfvars.example
├── .github/
│   └── workflows/
│       └── terraform-validate.yml
└── README.md
```

## Quick Start

1. Copy the example variables:
   ```bash
   cp terraform.tfvars.example terraform.tfvars
   ```

2. Edit `terraform.tfvars` with your details:
   ```hcl
   tenancy_ocid     = "ocid1.tenancy.oc1..xxxxxxxxxxxxxxxx"
   compartment_ocid = "ocid1.compartment.oc1..xxxxxxxxxxxxxxxx"
   allowed_ssh_ips  = ["YOUR_IP/32", "ANOTHER_IP/32"]
   ```

3. Deploy:
   ```bash
   terraform init
   terraform apply
   ```

4. Connect:
   ```bash
   ssh ubuntu@$(terraform output -raw instance_public_ip)
   ```

## Important Notes

- Always Free tier has limits (currently ~2 OCPU / 12 GB recommended to stay free).
- Never commit `terraform.tfvars` with real secrets.
- Update `allowed_ssh_ips` after deployment for better security.

## CI/CD

This project includes GitHub Actions that automatically:
- Check formatting (`terraform fmt`)
- Run `terraform validate`
- Show plan on every push/PR

## Destroy Resources

```bash
terraform destroy
```