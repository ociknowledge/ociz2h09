// Copyright (c) 2017, 2023, Oracle and/or its affiliates. All rights reserved.
// Licensed under the Mozilla Public License v2.0

variable "tenancy_ocid" {}
variable "compartment_ocid" {}
variable "region" {}
variable "vcn_display_name" {}
variable "cidr_block" {}
variable "dns_label" {}

provider "oci" {
    tenancy_ocid     = var.tenancy_ocid
    region           = var.region
    version          = 3.66
}

resource "oci_core_vcn" "vcn" {
  cidr_block    = var.cidr_block
  dns_label      = var.dns_label
  compartment_id = var.compartment_ocid
  display_name   = var.vcn_display_name
}

output "vcn_id" {
  value = oci_core_vcn.vcn.id
}