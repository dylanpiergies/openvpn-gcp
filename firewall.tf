resource "google_compute_firewall" "allow_internal" {
  name    = "allow-internal"
  project = data.google_project.project.project_id
  network = google_compute_network.network.self_link

  allow {
    protocol = "tcp"
    ports    = ["0-65535"]
  }

  allow {
    protocol = "udp"
    ports    = ["0-65535"]
  }

  allow {
    protocol = "icmp"
  }

  source_ranges = ["10.128.0.0/9"]
}

resource "google_compute_firewall" "allow_icmp" {
  name    = "allow-icmp"
  project = data.google_project.project.project_id
  network = google_compute_network.network.self_link

  allow {
    protocol = "icmp"
  }

  source_ranges = toset(concat(var.firewall_allow_openvpn_cidr_ranges, var.firewall_allow_ssh_cidr_ranges))
  target_tags   = ["openvpn-vm"]
}

resource "google_compute_firewall" "allow_ssh" {
  name    = "allow-ssh"
  project = data.google_project.project.project_id
  network = google_compute_network.network.self_link

  allow {
    protocol = "tcp"
    ports    = [22]
  }

  source_ranges = var.firewall_allow_ssh_cidr_ranges
  target_tags   = ["openvpn-vm"]
}


resource "google_compute_firewall" "allow_ssh_ipv6" {
  name    = "allow-ssh-ipv6"
  project = data.google_project.project.project_id
  network = google_compute_network.network.self_link

  allow {
    protocol = "tcp"
    ports    = [22]
  }

  source_ranges = var.firewall_allow_ssh_ipv6_cidr_ranges
  target_tags   = ["openvpn-vm"]
}

resource "google_compute_firewall" "allow_openvpn" {
  name    = "allow-openvpn"
  project = data.google_project.project.project_id
  network = google_compute_network.network.self_link

  allow {
    protocol = "udp"
    ports    = [1194]
  }

  source_ranges = var.firewall_allow_openvpn_cidr_ranges
  target_tags   = ["openvpn-vm"]
}

resource "google_compute_firewall" "allow_openvpn_ipv6" {
  name    = "allow-openvpn-ipv6"
  project = data.google_project.project.project_id
  network = google_compute_network.network.self_link

  allow {
    protocol = "udp"
    ports    = [1194]
  }

  source_ranges = var.firewall_allow_openvpn_ipv6_cidr_ranges
  target_tags   = ["openvpn-vm"]
}
