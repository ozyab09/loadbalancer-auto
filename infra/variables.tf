# Main

variable version {
  description = "Provider version"
  default     = "1.4.0"
}

variable project {
  description = "Project ID"
  default     = "keen-phalanx-223413"
}

variable region {
  description = "Region"
  default     = "europe-west1"
}

variable zone {
  description = "Zone"
  default     = "europe-west1-b"
}

variable instance_tag {
  description = "Tag of Instance"
  default     = "loadbalancer-auto"
}

variable serviceaccount_file {
  description = "Credentials JSON file"
  default     = "/root/serviceaccount.json"
}


variable public_key {
  description = "Path to public key"
  default     = "~/docker-user.pub"
}

variable ssh_key_private {
  description = "Path to private key"
  default     = "~/docker-user"
}

# Network
variable network {
  description = "CGP Network for Project"
  default     = "default"
}

variable local_subnet {
  description = "Subnet for project"
  default     = "10.132.0.0/24"
}

# Manager
variable mng_machine_type {
  description = "Machine Type of Manager"
  default     = "n1-standard-2"
}

variable mng_disk_size {
  description = "Disk Size if Manager"
  default     = 50
}

variable mng_disk_image {
  description = "Disk Image if Manager"
  default     = "ubuntu-1804-lts"
}

variable mng_int_ip {
  description = "Internal IP of Manager"
  default     = "10.132.0.100"
}

variable mng_int_ip_region {
  description = "Regional Of Manager Internal IP"
  default     = "europe-west1"
}

# Workers

variable wrk_machine_type {
  description = "Machine Type of Worker"
  default     = "n1-standard-2"
}

variable wrk_disk_size {
  description = "Disk Size of Worker"
  default     = 50
}

variable wrk_disk_image {
  description = "Disk Image of Worker"
  default     = "ubuntu-1804-lts"
}

variable wrk_int_ip_01 {
  description = "Internal IP of Wokrker-1"
  default     = "10.132.0.101"
}

variable wrk_int_ip_02 {
  description = "Internal IP of Wokrker-2"
  default     = "10.132.0.102"
}

variable wrk_int_ip_region {
  description = "Region Of Worker Internal IP"
  default     = "europe-west1"
}
