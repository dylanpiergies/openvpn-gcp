resource "google_dns_managed_zone" "openvpn" {
  name     = var.dns_managed_zone_name
  dns_name = var.dns_managed_zone_dns_name
}

resource "google_dns_record_set" "openvpn" {
  managed_zone = google_dns_managed_zone.openvpn.name
  name         = var.dns_record_set_openvpn_dns_name
  type         = "A"
  rrdatas      = [google_compute_instance.openvpn.network_interface[0].access_config[0].nat_ip]
  ttl          = 300
}

resource "google_dns_record_set" "openvpn_ipv6" {
  managed_zone = google_dns_managed_zone.openvpn.name
  name         = var.dns_record_set_openvpn_dns_name
  type         = "AAAA"
  rrdatas      = [google_compute_instance.openvpn.network_interface[0].ipv6_access_config[0].external_ipv6]
  ttl          = 300
}
