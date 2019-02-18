variable version {
  description = "Provider version"
}

variable project {
  description = "Project ID"
}

variable region {
  description = "Region"
}

variable zone {
  description = "Zone"
}

variable instance_tag {
  description = "Tag of Instance"
}

variable public_key {
  description = "Path to public key"
}

variable ssh_key_private {
  description = "Path to private key"
}

# Gitlab CI Token
variable gitlab_token {
  description = "Token for Gitlab CI"
}

# Network
variable network {
  description = "CGP Network for Project"
}

variable local_subnet {
  description = "Subnet for project"
}

# Manager
variable mng_machine_type {
  description = "Machine Type of Manager"
}

variable mng_disk_size {
  description = "Disk Size if Manager"
}

variable mng_disk_image {
  description = "Disk Image if Manager"
}

variable mng_int_ip {
  description = "Internal IP of Manager"
}

variable mng_int_ip_region {
  description = "Regional Of Manager Internal IP"
}

# Workers

variable wrk_machine_type {
  description = "Machine Type of Worker"
}

variable wrk_disk_size {
  description = "Disk Size of Worker"
}

variable wrk_disk_image {
  description = "Disk Image of Worker"
}

variable wrk_int_ip_01 {
  description = "Internal IP of Wokrker-1"
}

variable wrk_int_ip_02 {
  description = "Internal IP of Wokrker-2"
}

variable wrk_int_ip_region {
  description = "Region Of Worker Internal IP"
}
