output "openvpn_instance_ipv4_addr" {
  value = google_compute_instance.openvpn.network_interface[0].access_config[0].nat_ip
}

output "openvpn_instance_ipv6_addr" {
  value = google_compute_instance.openvpn.network_interface[0].ipv6_access_config[0].external_ipv6
}
