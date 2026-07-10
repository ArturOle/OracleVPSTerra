output "instance_public_ip" {
  description = "Public IP address of the Ubuntu instance"
  value       = oci_core_instance.ubuntu_a1.public_ip
}

output "ssh_command" {
  description = "Command to connect to the instance"
  value       = "ssh ubuntu@${oci_core_instance.ubuntu_a1.public_ip}"
}

output "vcn_id" {
  description = "VCN OCID"
  value       = oci_core_vcn.main.id
}
