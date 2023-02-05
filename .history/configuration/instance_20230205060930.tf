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
  # shape = "VM.Standard.A1.Flex"
  shape = "VM.Standard.E2.1"

  # shape_config {
  #   ocpus = var.instance_ocpus
  #   memory_in_gbs = var.instance_shape_config_memory_in_gbs
  # }
    
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
    "ssh_authorized_keys" = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQC4Z8mP7rmcWRo0pn89QUyFS+x7o42CoOgQScHsXA4IeAmw4UmS1jps2vJJ7UXVNAC4heEm6zk8QJOiGHajoLb0ABF8SotjS6U0NEWd3jp+eWE8k/IhotlUKkWTxYd3n56rBfXUJu/mLYP3EJOjHROk3DJ3eMYRpwSAXkVaeoHjEf6rvFTHAdh2y7XMwisCw5eZJlLqgZYDZ4d12WZz04jTXTx0POCbCxyf3+HSu/pjteln6mK7R9p3moJye/TuC11M3vXekq/dsAbbAO657qfZkaZGfAAdv9lZE21N/XgS4aLPw9x40nRXDMypVAle/uIrzu9r8VWNlaaVBwBDaJ06HxteKTA9oKEKDEH04d205Fh+oFubwYJMAG5EmHBJD+kyd1DvmdvFdmJshYcWx99/SgiIaTN6sCiNuJytnX98qLtNxXxmOr1UMQfTe79m5GupZrkxuP/mAFx942Rmt5eftnERQBZyfVlaLYoKykXE+g6+aigvW9N9yWBcnmq+jyc= maxparraaleu@Maxs-iMac.local"
  }

  preserve_boot_volume = false

  state = "RUNNING"
}