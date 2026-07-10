# Latest Ubuntu 24.04 Image
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
      apt-get update && apt-get upgrade -y
      apt-get install -y curl wget htop neofetch
      echo "=================================================="
      echo "Ubuntu 24.04 Ampere A1 Instance Ready!"
      echo "=================================================="
    EOF
    )
  }

  preserve_boot_volume = false
}

# Availability Domains
data "oci_identity_availability_domains" "ads" {
  compartment_id = var.tenancy_ocid
}
