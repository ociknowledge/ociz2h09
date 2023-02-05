data "oci_identity_availability_domain" "ad" {
  compartment_id = var.tenancy_ocid
  ad_number      = 1
}

resource "oci_core_instance" "oz2h_instance" {
    availability_domain         = data.oci_identity_availability_domain.ad.name
    fault_domain                = var.fault_domain
    compartment_id              = var.compartment_ocid
    shape = "VM.Standard.A1.Flex"

    create_vnic_details {
    subnet_id                 = oci_core_subnet.public_subnet.id
    display_name              = "Primaryvnic"
    assign_public_ip          = true
    # assign_private_dns_record = true
    # hostname_label            = "oz2h_instance"
  }

  display_name = "oz2h_instance"
  
  # agent_config {
  #   are_all_plugins_disabled = "false"
  #   is_management_disabled   = "false"
  #   is_monitoring_disabled   = "false"
  #   plugins_config {
  #     desired_state = "DISABLED"
  #     name          = "Vulnerability Scanning"
  #   }
  #   plugins_config {
  #     desired_state = "DISABLED"
  #     name          = "Oracle Java Management Service"
  #   }
  #   plugins_config {
  #     desired_state = "ENABLED"
  #     name          = "OS Management Service Agent"
  #   }
  #   plugins_config {
  #     desired_state = "ENABLED"
  #     name          = "Compute Instance Run Command"
  #   }
  #   plugins_config {
  #     desired_state = "ENABLED"
  #     name          = "Compute Instance Monitoring"
  #   }
  #   plugins_config {
  #     desired_state = "DISABLED"
  #     name          = "Block Volume Management"
  #   }
  #   plugins_config {
  #     desired_state = "DISABLED"
  #     name          = "Bastion"
  #   }
  # }

  # availability_config {
  #   recovery_action = "RESTORE_INSTANCE"
  # }

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

  shape_config {

      #Optional
      baseline_ocpu_utilization = "BASELINE_1_1"
      memory_in_gbs = "6"
      nvmes = "0"
      ocpus = "1"
  }
  
  source_details {
    source_type = "image"
    source_id = var.image_id
  }

  preserve_boot_volume = false

  state = "RUNNING"
}