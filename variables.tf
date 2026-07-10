variable "tenancy_ocid" {
  description = "Tenancy OCID"
  type        = string
}

variable "compartment_ocid" {
  description = "Compartment OCID (usually same as tenancy for root compartment)"
  type        = string
}

variable "region" {
  description = "OCI Region"
  type        = string
  default     = "us-ashburn-1"
}

variable "ssh_public_key" {
  description = "Path to SSH public key file"
  type        = string
  default     = "~/.ssh/id_rsa.pub"
}

variable "instance_display_name" {
  description = "Display name for the compute instance"
  type        = string
  default     = "ubuntu-a1-free"
}