variable "dns_zone_name" {
  description = "Name of the dns-zone."
}

variable "dns_a_record_names" {
  description = "Names of the DNS A-Records to create"
}

variable "dns_zone_rg_name" {
  description = "Name of the DNS-Zone resource group"
}

variable "ag_public_ip" {
  description = "IP-Address of the Application Gateway"
}

variable "location" {
  description = "Location/Region of the DNS-Zone"
}