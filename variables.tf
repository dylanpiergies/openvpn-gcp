variable "gcs_backend_storage_bucket" {
  type = string
}

variable "gcp_project_id" {
  type = string
}

variable "gcp_region" {
  type = string
}

variable "gcp_zone" {
  type = string
}

variable "dns_managed_zone_name" {
  type    = string
  default = "openvpn"
}

variable "dns_managed_zone_dns_name" {
  type     = string
  nullable = true
  default  = null
}

variable "dns_record_set_openvpn_dns_name" {
  type     = string
  nullable = true
  default  = null
}

variable "dns_record_set_ttl" {
  type    = number
  default = 300
}

variable "firewall_allow_openvpn_cidr_ranges" {
  type    = list(string)
  default = ["0.0.0.0/0"]
}

variable "firewall_allow_openvpn_ipv6_cidr_ranges" {
  type    = list(string)
  default = ["::/0"]
}

variable "firewall_allow_ssh_cidr_ranges" {
  type    = list(string)
  default = ["0.0.0.0/0"]
}

variable "firewall_allow_ssh_ipv6_cidr_ranges" {
  type    = list(string)
  default = ["::/0"]
}

variable "network_tier" {
  type    = string
  default = "PREMIUM"
}

variable "openvpn_subnet_cidr" {
  type    = string
  default = "10.8.0.0/24"
}

variable "openvpn_subnet_ipv6_cidr" {
  type    = string
  default = "fd00::/64"
}
