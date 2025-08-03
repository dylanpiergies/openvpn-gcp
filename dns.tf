resource "google_dns_managed_zone" "openvpn" {
  count = var.dns_managed_zone_dns_name != null ? 1 : 0

  name     = var.dns_managed_zone_name
  dns_name = var.dns_managed_zone_dns_name
}

resource "google_dns_record_set" "openvpn" {
  count = var.dns_record_set_openvpn_dns_name != null ? 1 : 0

  managed_zone = google_dns_managed_zone.openvpn.0.name
  name         = var.dns_record_set_openvpn_dns_name
  type         = "A"
  rrdatas      = [google_compute_instance.openvpn.network_interface[0].access_config[0].nat_ip]
  ttl          = var.dns_record_set_ttl
}

resource "google_dns_record_set" "openvpn_ipv6" {
  count = var.dns_record_set_openvpn_dns_name != null ? 1 : 0

  managed_zone = google_dns_managed_zone.openvpn.0.name
  name         = var.dns_record_set_openvpn_dns_name
  type         = "AAAA"
  rrdatas      = [google_compute_instance.openvpn.network_interface[0].ipv6_access_config[0].external_ipv6]
  ttl          = var.dns_record_set_ttl
}
