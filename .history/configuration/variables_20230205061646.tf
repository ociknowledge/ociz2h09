variable "tenancy_ocid" {}
variable "compartment_ocid" {}
variable "region" {}
variable "vcn_cidr" {}
variable "vcn_name" {}
variable "vcn_dns_label" {}
variable "internet_gateway_display_name" {}
#image id from Ruthford
#variable "image_id" {default = "ocid1.image.oc1.iad.aaaaaaaaouyvuz4yysgthwrbh5iyx46pveyviyh4a2e2mri6sqo2bs44mg2a"}
#image id from Max
variable "image_id" {default = "ocid1.image.oc1.iad.aaaaaaaanw4c2wtgohotx5qo62upm3tlfegukt47sdyuq6dw7hbirbwdxahq"}
variable "fault_domain" { default = "FAULT-DOMAIN-3" }