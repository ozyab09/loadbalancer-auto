# External IP
resource "google_compute_address" "swarm-mng-ext" {
  name = "swarm-mng-ext"
}
resource "google_compute_address" "swarm-wrk-ext-01" {
  name = "swarm-mng-ext-01"
}

resource "google_compute_address" "swarm-wrk-ext-02" {
  name = "swarm-mng-ext-02"
}

# Internal IP
resource "google_compute_address" "swarm-mng-int" {
  name         = "swarm-mng-int"
  address_type = "INTERNAL"
  address      = "${var.mng_int_ip}"
  region       = "${var.mng_int_ip_region}"
}
resource "google_compute_address" "swarm-wrk-int-01" {
  name         = "swarm-wrk-int-01"
  address_type = "INTERNAL"
  address      = "${var.wrk_int_ip_01}"
  region       = "${var.wrk_int_ip_region}"
}

resource "google_compute_address" "swarm-wrk-int-02" {
  name         = "swarm-mng-wrk-02"
  address_type = "INTERNAL"
  address      = "${var.wrk_int_ip_02}"
  region       = "${var.wrk_int_ip_region}"
}