// Copyright (c) 2017, 2023, Oracle and/or its affiliates. All rights reserved.
// Licensed under the Mozilla Public License v2.0

variable "tenancy_ocid" {}
variable "compartment_ocid" {}
variable "region" {}
variable "vcn_cidrs" {}
variable "vcn_name" {}
variable "vcn_dns_label" {}

provider "oci" {
    tenancy_ocid     = var.tenancy_ocid
    region           = var.region
    version          = 3.66
}

resource "oci_core_vcn" "vcn" {
  cidr_blocks    = var.vcn_cidrs
  compartment_id = var.compartment_ocid
  display_name   = var.vcn_name
  dns_label      = var.vcn_dns_label
}

output "vcn_id" {
  value = oci_core_vcn.vcn.id
}