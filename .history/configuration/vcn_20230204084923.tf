// Copyright (c) 2017, 2023, Oracle and/or its affiliates. All rights reserved.
// Licensed under the Mozilla Public License v2.0

variable "tenancy_ocid" {}
variable "compartment_ocid" {}
variable "region" {}
variable "vcn_cidr" {}
variable "vcn_name" {}
variable "vcn_dns_label" {}
variable "subnets" {
  description = "Private or Public subnets in a VCN"
  type        = any
  default     = {}
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

#Module for Subnet
module "subnet" {
  source = "./modules/subnet"

  compartment_id = var.compartment_ocid
  subnets        = var.subnets
  enable_ipv6    = var.enable_ipv6
  vcn_id         = oci_core_vcn.vcn.id
  ig_route_id    = var.create_internet_gateway ? oci_core_route_table.ig[0].id : null
  nat_route_id   = var.create_nat_gateway ? oci_core_route_table.nat[0].id : null

  freeform_tags = var.freeform_tags

  count = length(var.subnets) > 0 ? 1 : 0

}

output "vcn_id" {
  value = oci_core_vcn.vcn.id
}