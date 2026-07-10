variable "tenancy_ocid" {
  description = "Tenancy OCID"
  type        = string
}

variable "compartment_ocid" {
  description = "Compartment OCID"
  type        = string
}

variable "region" {
  description = "OCI Region"
  type        = string
  default     = "us-ashburn-1"
}

variable "ssh_public_key" {
  description = "Path to your SSH public key"
  type        = string
  default     = "~/.ssh/id_rsa.pub"
}

variable "allowed_ssh_ips" {
  description = "List of IPs or CIDRs allowed to SSH"
  default     = ["0.0.0.0/0"] # Change this! Do not leave as 0.0.0.0/0
}

variable "instance_display_name" {
  description = "Name of the compute instance"
  type        = string
  default     = "ubuntu-a1-secure"
}