resource "google_compute_network" "network" {
  name = "openvpn"

  auto_create_subnetworks = false
}

resource "google_compute_subnetwork" "subnetwork" {
  name   = "openvpn"
  region = var.gcp_region

  stack_type       = "IPV4_IPV6"
  ip_cidr_range    = "10.128.0.0/20"
  ipv6_access_type = "EXTERNAL"

  network = google_compute_network.network.id
}
