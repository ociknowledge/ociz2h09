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
  cidr_block     = var.vcn_cidr
  compartment_id = var.compartment_ocid
  display_name   = var.vcn_name
  dns_label      = var.vcn_dns_label
}

resource "oci_core_subnet" "test_subnet" {
  availability_domain = data.oci_identity_availability_domain.ad.name
  cidr_block          = "10.0.0.0/24"
  display_name        = "publicSubnet"
  dns_label           = "publicSubnet"
  security_list_ids   = [oci_core_vcn.vcn.default_security_list_id]
  compartment_id      = var.compartment_ocid
  vcn_id              = oci_core_vcn.vcn.id
  route_table_id      = oci_core_vcn.vcn.default_route_table_id
  dhcp_options_id     = oci_core_vcn.vcn.default_dhcp_options_id
}

resource "oci_core_internet_gateway" "ig" {
  compartment_id = var.compartment_ocid
  display_name   = var.internet_gateway_display_name
  vcn_id = oci_core_vcn.vcn.id
}

resource "oci_core_route_table" "ig" {
  compartment_id = var.compartment_ocid
  display_name   = var.label_prefix == "none" ? "internet-route" : "${var.label_prefix}-internet-route"

  freeform_tags = var.freeform_tags
  defined_tags = var.defined_tags

  route_rules {
    # * With this route table, Internet Gateway is always declared as the default gateway
    destination       = local.anywhere
    network_entity_id = oci_core_internet_gateway.ig[0].id
    description       = "Terraformed - Auto-generated at Internet Gateway creation: Internet Gateway as default gateway"
  }
}

output "vcn_id" {
  value = oci_core_vcn.vcn.id
}