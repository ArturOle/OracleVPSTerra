# Ubuntu 24.04 Image
data "oci_core_images" "ubuntu_24" {
  compartment_id           = var.compartment_ocid
  operating_system         = "Canonical Ubuntu"
  operating_system_version = "24.04"
  shape                    = "VM.Standard.A1.Flex"
  sort_by                  = "TIMECREATED"
  sort_order               = "DESC"
}

# Compute Instance
resource "oci_core_instance" "ubuntu_a1" {
  availability_domain = data.oci_identity_availability_domains.ads.availability_domains[0].name
  compartment_id      = var.compartment_ocid
  display_name        = var.instance_display_name
  shape               = "VM.Standard.A1.Flex"

  shape_config {
    ocpus         = 4
    memory_in_gbs = 24
  }

  source_details {
    source_type             = "image"
    source_id               = data.oci_core_images.ubuntu_24.images[0].id
    boot_volume_size_in_gbs = 50
  }

  create_vnic_details {
    subnet_id        = oci_core_subnet.public.id
    assign_public_ip = true
    display_name     = "primary-vnic"
  }

  metadata = {
    ssh_authorized_keys = file(var.ssh_public_key)
    user_data = base64encode(<<-EOF
      #!/bin/bash
      export DEBIAN_FRONTEND=noninteractive

      apt-get update && apt-get upgrade -y
      apt-get install -y fail2ban ufw curl htop neofetch

      # Hardening SSH
      sed -i 's/#PasswordAuthentication yes/PasswordAuthentication no/' /etc/ssh/sshd_config
      sed -i 's/#PermitRootLogin.*/PermitRootLogin no/' /etc/ssh/sshd_config
      systemctl restart ssh

      # Fail2Ban
      systemctl enable --now fail2ban

      # UFW Firewall - Allow all IPs from the list
      ufw default deny incoming
      ufw default allow outgoing

      %{for ip in var.allowed_ssh_ips~}
      ufw allow from ${ip} to any port 22 proto tcp
      %{endfor~}

      ufw --force enable

      echo "=================================================="
      echo "Secure Ubuntu 24.04 Ampere A1 Instance Ready!"
      echo "Allowed SSH IPs: ${join(", ", var.allowed_ssh_ips)}"
      echo "=================================================="
    EOF
    )
  }

  preserve_boot_volume = false
}

data "oci_identity_availability_domains" "ads" {
  compartment_id = var.tenancy_ocid
}