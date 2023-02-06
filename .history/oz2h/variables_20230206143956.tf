variable "tenancy_ocid" {}
variable "compartment_ocid" {}
variable "region" {}

variable "vcn_name" {}
variable "vcn_dns_label" {}
variable "internet_gateway_display_name" {}
variable "image_id" {}
variable "fault_domain" {}
variable "instance_display_name" {}
variable "instance_ocpus" {default = 1}
variable "instance_shape_config_memory_in_gbs" {default = 6}
