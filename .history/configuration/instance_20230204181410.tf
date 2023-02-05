resource "oci_core_private_ip" "private_ip" {
  display_name = "private_ip"
  freeform_tags = {
  }
  hostname_label = "instance-20230204-0735"
  ip_address     = "10.0.0.40"
  #vlan_id = <<Optional value not found in discovery>>
  vnic_id = "ocid1.vnic.oc1.iad.abuwcljt5uwfnlttbdnwwlyyqcqmw4x4ryadvalqzvsobvvmauokh6bwqzkq"
}

resource oci_core_route_table export_Route-Table-for-Private-Subnet-vcn-oz2h {
  compartment_id = oci_artifacts_container_configuration.export_container_configuration.id
  defined_tags = {
    "Oracle-Standard.CostCenter" = "johanna.gutierrez"
    "Oracle-Tags.CreatedBy"      = "default/max.parra@oracle.com"
    "Oracle-Tags.CreatedOn"      = "2023-02-04T12:34:51.071Z"
    "Schedule.SHUTDOWN"          = "Yes"
  }
  display_name = "Route Table for Private Subnet-vcn-oz2h"
  freeform_tags = {
    "VCN" = "VCN-2023-02-04T12:34:23"
  }
  route_rules {
    #description = <<Optional value not found in discovery>>
    destination       = "0.0.0.0/0"
    destination_type  = "CIDR_BLOCK"
    network_entity_id = oci_core_nat_gateway.export_NAT-Gateway-vcn-oz2h.id
    #route_type = <<Optional value not found in discovery>>
  }
  route_rules {
    #description = <<Optional value not found in discovery>>
    destination       = "all-iad-services-in-oracle-services-network"
    destination_type  = "SERVICE_CIDR_BLOCK"
    network_entity_id = oci_core_service_gateway.export_Service-Gateway-vcn-oz2h.id
    #route_type = <<Optional value not found in discovery>>
  }
  vcn_id = oci_core_vcn.export_vcn-oz2h.id
}

resource oci_core_default_route_table export_Default-Route-Table-for-vcn-oz2h {
  compartment_id = oci_artifacts_container_configuration.export_container_configuration.id
  defined_tags = {
    "Oracle-Standard.CostCenter" = "johanna.gutierrez"
    "Oracle-Tags.CreatedBy"      = "default/max.parra@oracle.com"
    "Oracle-Tags.CreatedOn"      = "2023-02-04T12:34:49.503Z"
    "Schedule.SHUTDOWN"          = "Yes"
  }
  display_name = "Default Route Table for vcn-oz2h"
  freeform_tags = {
    "VCN" = "VCN-2023-02-04T12:34:23"
  }
  manage_default_resource_id = oci_core_vcn.export_vcn-oz2h.default_route_table_id
  route_rules {
    #description = <<Optional value not found in discovery>>
    destination       = "0.0.0.0/0"
    destination_type  = "CIDR_BLOCK"
    network_entity_id = oci_core_internet_gateway.export_Internet-Gateway-vcn-oz2h.id
    #route_type = <<Optional value not found in discovery>>
  }
}

resource oci_core_instance export_instance-20230204-0735_1 {
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
  #async = <<Optional value not found in discovery>>
  availability_config {
    #is_live_migration_preferred = <<Optional value not found in discovery>>
    recovery_action = "RESTORE_INSTANCE"
  }
  availability_domain = var.availability_domain--YxuQ-US-ASHBURN-AD-1
  #capacity_reservation_id = <<Optional value not found in discovery>>
  compartment_id = oci_artifacts_container_configuration.export_container_configuration.id
  create_vnic_details {
    #assign_private_dns_record = <<Optional value not found in discovery>>
    assign_public_ip = "true"
    defined_tags = {
      "Oracle-Standard.CostCenter" = "johanna.gutierrez"
      "Oracle-Tags.CreatedBy"      = "default/max.parra@oracle.com"
      "Oracle-Tags.CreatedOn"      = "2023-02-04T12:36:26.461Z"
      "Schedule.SHUTDOWN"          = "Yes"
    }
    display_name = "instance-20230204-0735"
    freeform_tags = {
    }
    hostname_label = "instance-20230204-0735"
    nsg_ids = [
    ]
    private_ip             = "10.0.0.40"
    skip_source_dest_check = "false"
    subnet_id              = oci_core_subnet.export_Public-Subnet-vcn-oz2h.id
    #vlan_id = <<Optional value not found in discovery>>
  }
  #dedicated_vm_host_id = <<Optional value not found in discovery>>
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
  freeform_tags = {
  }
  instance_options {
    are_legacy_imds_endpoints_disabled = "false"
  }
  #ipxe_script = <<Optional value not found in discovery>>
  #is_pv_encryption_in_transit_enabled = <<Optional value not found in discovery>>
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
  #preserve_boot_volume = <<Optional value not found in discovery>>
  shape = "VM.Standard.A1.Flex"
  shape_config {
    baseline_ocpu_utilization = ""
    memory_in_gbs             = "6"
    nvmes                     = "0"
    ocpus                     = "1"
  }
  source_details {
    #boot_volume_size_in_gbs = <<Optional value not found in discovery>>
    boot_volume_vpus_per_gb = "10"
    #kms_key_id = <<Optional value not found in discovery>>
    source_id   = var.oci_core_instance--source_details-source_id--export_instance-20230204-0735_1
    source_type = "image"
  }
  state = "RUNNING"
}