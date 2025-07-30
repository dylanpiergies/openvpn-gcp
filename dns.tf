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
