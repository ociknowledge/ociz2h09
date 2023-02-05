data "oci_identity_availability_domain" "ad" {
  compartment_id = var.tenancy_ocid
  ad_number      = 1
}

resource "oci_core_private_ip" "private_ip" {
  display_name = "private_ip"
  hostname_label = "instance-oz2h"
  ip_address     = "10.0.0.40"
  vnic_id = "ocid1.vnic.oc1.iad.abuwcljt5uwfnlttbdnwwlyyqcqmw4x4ryadvalqzvsobvvmauokh6bwqzkq"
}

resource oci_core_instance export_instance-20230204-0735_1 {
  
    #Required
    availability_domain = var.instance_availability_domain
    compartment_id = var.compartment_id
    shape = var.instance_shape
  
  
  agent_config {
    are_all_plugins_disabled = "false"
    is_management_disabled   = "false"
    is_monitoring_disabled   = "false"
    plugins_config {
      desired_state = "DISABLED"
      name          = "Vulnerability Scanning"
    }
    plugins_config {
      desired_state = "DISABLED"
      name          = "Oracle Java Management Service"
    }
    plugins_config {
      desired_state = "ENABLED"
      name          = "OS Management Service Agent"
    }
    plugins_config {
      desired_state = "ENABLED"
      name          = "Compute Instance Run Command"
    }
    plugins_config {
      desired_state = "ENABLED"
      name          = "Compute Instance Monitoring"
    }
    plugins_config {
      desired_state = "DISABLED"
      name          = "Block Volume Management"
    }
    plugins_config {
      desired_state = "DISABLED"
      name          = "Bastion"
    }
  }

  availability_config {
    recovery_action = "RESTORE_INSTANCE"
  }

  availability_domain = var.availability_domain--YxuQ-US-ASHBURN-AD-1

  compartment_id = oci_artifacts_container_configuration.export_container_configuration.id
  create_vnic_details {
    assign_public_ip = "true"

    display_name = "instance-20230204-0735"

    hostname_label = "instance-20230204-0735"
    nsg_ids = [
    ]
    private_ip             = "10.0.0.40"
    skip_source_dest_check = "false"
    subnet_id              = oci_core_subnet.export_Public-Subnet-vcn-oz2h.id

  }

  defined_tags = {
    "Oracle-Standard.CostCenter" = "johanna.gutierrez"
    "Oracle-Tags.CreatedBy"      = "default/max.parra@oracle.com"
    "Oracle-Tags.CreatedOn"      = "2023-02-04T12:36:26.248Z"
    "Schedule.SHUTDOWN"          = "Yes"
  }
  display_name = "instance-20230204-0735"
  extended_metadata = {
  }
  fault_domain = var.fault_domain--FAULT-DOMAIN-3

  instance_options {
    are_legacy_imds_endpoints_disabled = "false"
  }

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

  shape = "VM.Standard.A1.Flex"
  shape_config {
    baseline_ocpu_utilization = ""
    memory_in_gbs             = "6"
    nvmes                     = "0"
    ocpus                     = "1"
  }
  source_details {
    boot_volume_vpus_per_gb = "10"
    source_id   = var.oci_core_instance--source_details-source_id--export_instance-20230204-0735_1
    source_type = "image"
  }
  state = "RUNNING"
}