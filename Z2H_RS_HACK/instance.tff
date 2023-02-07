data "oci_identity_availability_domain" "ad" {
  compartment_id = var.tenancy_ocid
  ad_number      = var.ad
}

resource "oci_core_instance" "oz2h_instance" {
  availability_domain         = data.oci_identity_availability_domain.ad.name
  fault_domain                = var.fault_domain
  compartment_id              = var.compartment_ocid
  shape = "VM.Standard.E2.1"
  source_details {
    source_type = "image"
    source_id = var.image_id
  }

  create_vnic_details {
    subnet_id                 = oci_core_subnet.public_subnet.id
    display_name              = "hackvm"
    assign_public_ip          = true
  }

  display_name = var.instance_display_name

  launch_options {
    boot_volume_type                    = "PARAVIRTUALIZED"
    firmware                            = "UEFI_64"
    is_consistent_volume_naming_enabled = "true"
    network_type                        = "PARAVIRTUALIZED"
    remote_data_volume_type             = "PARAVIRTUALIZED"
  }

  metadata = {
    "ssh_authorized_keys" = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQCcckYJvbQg6/gKwpWFZnmoW6rbsApaGbiIywjBwWl48F4eXEKZw8X39+PKF/ETMPy7UY+IpoSfRalzh/L1j0KxmWjdruxlMVA5BooGPeqZet/ZvrwJ1WvkkafJHuyqFClDoOg4Z/he5GBK+AlK8gOYbm+JVIILs3oZYdu2hc6L+9Y9/IhTm2zq9Oi/ADx/7b08F4XxAUZih4crp6X/iw/nshuWH6pwSDrv+GDs1HoXJW50bgXgPos2gtBVDYyu7pH90ZubJxv7crNH77DbF1NMw682W2Xb0YTcC4vobPTfOCx3PWVdSexyT+fnXE8+f9aJm024oE4drf4wMxcdzcCN FromZeroToHeroSSHKey"
  }

  preserve_boot_volume = false

  state = "RUNNING"
}