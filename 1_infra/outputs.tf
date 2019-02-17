# Manager
output "swarm-mng-ext" {
  value = "${google_compute_address.swarm-mng-ext.address}"
}

output "swarm-mng-int" {
  value = "${google_compute_address.swarm-mng-int.address}"
}

# Workers
output "swarm-wrk-ext-01" {
  value = "${google_compute_address.swarm-wrk-ext-01.address}"
}
output "swarm-wrk-ext-02" {
  value = "${google_compute_address.swarm-wrk-ext-02.address}"
}

output "swarm-wrk-int-01" {
  value = "${google_compute_address.swarm-wrk-int-01.address}"
}
output "swarm-wrk-int-02" {
  value = "${google_compute_address.swarm-wrk-int-02.address}"
}