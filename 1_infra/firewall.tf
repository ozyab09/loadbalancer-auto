resource "google_compute_firewall" "loadbalancer-auto-all" {
  name    = "loadbalancer-auto-all"
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
