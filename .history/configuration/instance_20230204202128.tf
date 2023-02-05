data "oci_identity_availability_domain" "ad" {
  compartment_id = var.tenancy_ocid
  ad_number      = 1
}

variable "instance_ocpus" {
  default = 1
}

variable "instance_shape_config_memory_in_gbs" {
  default = 6
}


resource "oci_core_instance" "oz2h_instance" {
  availability_domain         = data.oci_identity_availability_domain.ad.name
  fault_domain                = var.fault_domain
  compartment_id              = var.compartment_ocid
  shape = "VM.Standard.A1.Flex"

  shape_config {
    ocpus = var.instance_ocpus
    memory_in_gbs = var.instance_shape_config_memory_in_gbs
  }

    
  source_details {
    source_type = "image"
    source_id = var.image_id
  }

  create_vnic_details {
    subnet_id                 = oci_core_subnet.public_subnet.id
    display_name              = "Primaryvnic"
    assign_public_ip          = true
  }



  display_name = "oz2h_instance"

  launch_options {
    boot_volume_type                    = "PARAVIRTUALIZED"
    firmware                            = "UEFI_64"
    is_consistent_volume_naming_enabled = "true"
    is_pv_encryption_in_transit_enabled = "false"
    network_type                        = "PARAVIRTUALIZED"
    remote_data_volume_type             = "PARAVIRTUALIZED"
  }

  metadata = {
    "ssh_authorized_keys" = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQCfAlRP9OJducfZ5VHjtqg7M8uU3mauKDz20rGu/efbs2zSOVtZ+Ly9/Davq2lddwgAQhg8kWdRTr2Scezwg+yJasB2gRQ4NPEiZjTpkLrqaaTf7QgRdlSdzEMUDV1hsXLfCU3tusX1w+1D9ft/AqOi6KBwJ8MzT9LNxFrAj7NEssuEctlB8XCLuqe7OCbH5AKY/nyk9c0Xciyxp28BOCySvan0TpOrVn5tMTCsn1JXDdIPKg5T9VegQW93XAtw3d+mQM1NXuGWx6yHbJmtveXB2pFkOBfPHIuF70qUgitplJ2LfW1ULY0zxcSML/LOj2JUemTkJTLLvpDyZmwum0Td ssh-key-2023-02-04"
  }

  preserve_boot_volume = false

  state = "RUNNING"
}