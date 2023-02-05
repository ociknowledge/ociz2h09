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

resource "oci_core_route_table" "default_route_table_id" {
  compartment_id = var.compartment_ocid
  vcn_id         = oci_core_vcn.vcn.id

  manage_default_resource_id = oci_core_vcn.vcn.default_route_table_id

  route_rules {
    destination       = "0.0.0.0/0"
    destination_type  = "CIDR_BLOCK"
    network_entity_id = oci_core_internet_gateway.ig.id
  }
}

output "vcn_id" {
  value = oci_core_vcn.vcn.id
}