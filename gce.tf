data "cloudinit_config" "openvpn_server" {
  gzip          = false
  base64_encode = false

  part {
    content_type = "text/cloud-config"
    content = templatefile("cloud-init.yaml", {
      openvpn_server_config = base64encode(templatefile("openvpn-server.conf", {
        openvpn_subnet_cidr      = var.openvpn_subnet_cidr
        openvpn_subnet_ipv6_cidr = var.openvpn_subnet_ipv6_cidr
      }))
      openvpn_ca_cert     = base64encode(file("pki/ca.crt"))
      openvpn_server_cert = base64encode(file("pki/server.crt"))
      openvpn_server_key  = base64encode(file("pki/server.key"))
      openvpn_dh_params   = base64encode(file("pki/dh2048.pem"))
      iptables_rules_v4 = base64encode(templatefile("iptables-rules.v4", {
        openvpn_subnet_cidr = var.openvpn_subnet_cidr
      }))
      iptables_rules_v6 = base64encode(templatefile("iptables-rules.v6", {
        openvpn_subnet_ipv6_cidr = var.openvpn_subnet_ipv6_cidr
      }))
      sysctl_conf = base64encode(file("sysctl.conf"))
    })
    filename = "cloud-init.yaml"
  }
}

resource "google_compute_instance" "openvpn" {
  project      = data.google_project.project.project_id
  name         = "openvpn"
  machine_type = "e2-micro"

  boot_disk {
    initialize_params {
      image = "ubuntu-minimal-2404-lts-amd64"
    }
  }

  network_interface {
    subnetwork_project = google_compute_subnetwork.subnetwork.project
    subnetwork         = google_compute_subnetwork.subnetwork.self_link

    stack_type = "IPV4_IPV6"

    access_config {
      network_tier = var.network_tier
    }

    ipv6_access_config {
      network_tier = var.network_tier
    }
  }

  can_ip_forward = true

  metadata = {
    user-data = data.cloudinit_config.openvpn_server.rendered
  }

  tags = ["openvpn-vm"]
}
