provider "google" {
  project = var.project
  region  = var.region
  zone    = var.zone
}

resource "google_compute_instance" "eve-ng_instance" {
  name         = var.instance_name
  machine_type = var.machine_type

  boot_disk {
    initialize_params {
      image = data.google_compute_image.eve-ng_image.self_link
      size  = var.disk_size
      type  = var.disk_type
    }
  }

  network_interface {
    network = "default"

    access_config {
      // Ephemeral public IP
    }
  }

  advanced_machine_features {
    enable_nested_virtualization = true
  }

  service_account {
    email  = var.service_account
    scopes = ["cloud-platform"]
  }

  metadata_startup_script = data.template_file.default.rendered
}

data "google_compute_image" "eve-ng_image" {
  family  = var.image_family
  project = var.image_project
}

resource "google_compute_firewall" "firewall_allow_ingress" {
  name          = "allow-ingress"
  network       = "default"
  direction     = "INGRESS"
  source_ranges = ["0.0.0.0/0"]
  priority      = 500

  allow {
    protocol = "tcp"
    ports    = ["0-65535"]
  }
}

resource "google_compute_firewall" "firewall_allow_egress" {
  name               = "allow-egress"
  network            = "default"
  direction          = "EGRESS"
  destination_ranges = ["0.0.0.0/0"]
  priority           = 500

  allow {
    protocol = "icmp"
  }

  allow {
    protocol = "tcp"
    ports    = ["0-65535"]
  }
}

data "template_file" "default" {
  template = file("${path.module}/scripts/ddns.sh")
  vars = {
    ddns_hostname = var.ddns_hostname
    ddns_username = var.ddns_username
    ddns_password = var.ddns_password
  }
}
