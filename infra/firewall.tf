resource "google_compute_firewall" "loadbalancer-internal" {
  name    = "loadbalancer-internal"
  network = "${var.network}"

  allow {
    protocol = "tcp"
    ports    = ["0-65000"]
  }

  allow {
    protocol = "udp"
    ports    = ["0-65000"]
  }

  source_ranges = ["${var.local_subnet}"]
  target_tags   = ["${var.instance_tag}"]
}

resource "google_compute_firewall" "loadbalancer-external" {
  name    = "loadbalancer-external"
  network = "${var.network}"

  allow {
    protocol = "tcp"
    ports    = ["80"]
  }

  allow {
    protocol = "tcp"
    ports    = ["443"]
  }

  allow {
    protocol = "tcp"
    ports    = ["8080"]
  }

  source_ranges = ["0.0.0.0/0"]
  target_tags   = ["${var.instance_tag}"]
}
