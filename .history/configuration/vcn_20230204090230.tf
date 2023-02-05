// Copyright (c) 2017, 2023, Oracle and/or its affiliates. All rights reserved.
// Licensed under the Mozilla Public License v2.0

variable "tenancy_ocid" {}
variable "compartment_ocid" {}
variable "region" {}
variable "vcn_cidr" {}
variable "vcn_name" {}
variable "vcn_dns_label" {}

data "oci_identity_availability_domain" "ad" {
  compartment_id = var.tenancy_ocid
  ad_number      = 1
}

provider "oci" {
    tenancy_ocid     = var.tenancy_ocid
    region           = var.region
    version          = 3.66
}

resource "oci_core_vcn" "vcn" {
  cidr_block     = var.cidr_block
  compartment_id = var.compartment_ocid
  display_name   = var.vcn_name
  dns_label      = var.vcn_dns_label
}

resource "oci_core_subnet" "test_subnet" {
  availability_domain = data.oci_identity_availability_domain.ad.name
  cidr_block          = "10.1.20.0/24"
  display_name        = "testSubnet"
  dns_label           = "tfsubnet"
  security_list_ids   = [oci_core_vcn.test_vcn.default_security_list_id]
  compartment_id      = var.compartment_ocid
  vcn_id              = oci_core_vcn.test_vcn.id
  route_table_id      = oci_core_vcn.test_vcn.default_route_table_id
  dhcp_options_id     = oci_core_vcn.test_vcn.default_dhcp_options_id
}


output "vcn_id" {
  value = oci_core_vcn.vcn.id
}