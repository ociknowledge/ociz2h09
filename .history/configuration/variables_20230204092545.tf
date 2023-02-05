variable "tenancy_ocid" {}
variable "compartment_ocid" {}
variable "region" {}
variable "vcn_cidr" {}
variable "vcn_name" {}
variable "vcn_dns_label" {}
variable "internet_gateway_display_name" {
  description = "(Updatable) Name of Internet Gateway. Does not have to be unique."
  type        = string
  default     = "internet-gateway"

  validation {
    condition     = length(var.internet_gateway_display_name) > 0
    error_message = "The internet_gateway_display_name value cannot be an empty string."
  }
}