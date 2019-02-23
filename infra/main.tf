provider "google" {
  version = "1.4.0"
  project = "${var.project}"
  region  = "${var.region}"
  zone    = "${var.zone}"
  credentials = "${var.serviceaccount_file}"
}

resource "google_compute_instance" "swarm-mng" {
  name         = "swarm-mng"
  machine_type = "${var.mng_machine_type}"
  tags         = ["${var.instance_tag}"]

  metadata {
    ssh-keys = "docker-user:${file(var.public_key)}"
  }

  boot_disk {
    initialize_params {
      size  = "${var.mng_disk_size}"
      image = "${var.mng_disk_image}"
    }
  }

  network_interface {
    network = "${var.network}"

    access_config {
      nat_ip = "${google_compute_address.swarm-mng-ext.address}"
    }

    address = "${google_compute_address.swarm-mng-int.address}"
  }

  connection {
    user = "docker-user"

    # key_file = "ssh/key"
  }

  provisioner "file" {
    source      = "${var.ssh_key_private}"
    destination = "/home/docker-user/key.pem"
  }

  provisioner "file" {
    source      = "./runner-stack.yml"
    destination = "/home/docker-user/runner-stack.yml"
  }

  provisioner "remote-exec" {
    inline = [
      "sudo apt-get update",
      "sudo apt-get install -y apt-transport-https ca-certificates curl software-properties-common",
      "curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -",
      "sudo add-apt-repository 'deb [arch=amd64] https://download.docker.com/linux/ubuntu bionic stable'",
      "sudo apt-get update",

      # install docker
      "apt-cache policy docker-ce",

      "sudo apt install -y docker-ce",
      "sudo systemctl enable docker",
      "sudo systemctl start docker",

      # init swarm
      "sudo docker swarm init",

      "sudo docker swarm join-token --quiet worker > /home/docker-user/token",

      # update label
      "sudo docker node update --label-add role=master swarm-mng",

      # install gitlab-runner
      "sudo mkdir -p /opt/docker/etc-gitlab-runner/",

      "sudo docker run --rm -t -i -v /opt/docker/etc-gitlab-runner:/etc/gitlab-runner --name gitlab-runner gitlab/gitlab-runner register --non-interactive --executor \"docker\" --docker-image alpine:3 --url \"https://gitlab.com/\" --registration-token \"$gitlab_token\" --description \"swarm-mng\" --tag-list \"docker,master,loadbalancer\" --run-untagged   --locked=\"false\"",

      # run gitlab-runner
      "sudo docker stack deploy -c /home/docker-user/runner-stack.yml runner",
    ]
  }
}

resource "google_compute_instance" "swarm-wrk-01" {
  name         = "swarm-wrk-01"
  machine_type = "${var.wrk_machine_type}"
  tags         = ["${var.instance_tag}"]
  depends_on   = ["google_compute_instance.swarm-mng"]

  metadata {
    ssh-keys = "docker-user:${file(var.public_key)}"
  }

  boot_disk {
    initialize_params {
      size  = "${var.wrk_disk_size}"
      image = "${var.wrk_disk_image}"
    }
  }

  network_interface {
    network = "${var.network}"

    access_config {
      nat_ip = "${google_compute_address.swarm-wrk-ext-01.address}"
    }

    address = "${google_compute_address.swarm-wrk-int-01.address}"
  }

  connection {
    user = "docker-user"

    # key_file = "ssh/key"
  }

  provisioner "file" {
    source      = "${var.ssh_key_private}"
    destination = "/home/docker-user/key.pem"
  }

  provisioner "remote-exec" {
    inline = [
      "sudo apt-get update",
      "sudo apt-get install -y apt-transport-https ca-certificates curl software-properties-common",
      "curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -",
      "sudo add-apt-repository 'deb [arch=amd64] https://download.docker.com/linux/ubuntu bionic stable'",
      "sudo apt-get update",
      "apt-cache policy docker-ce",
      "sudo apt install -y docker-ce",
      "sudo systemctl enable docker",
      "sudo systemctl start docker",
      "sudo chmod 400 /home/docker-user/key.pem",
      "sudo scp -o StrictHostKeyChecking=no -o NoHostAuthenticationForLocalhost=yes -o UserKnownHostsFile=/dev/null -i /home/docker-user/key.pem docker-user@${google_compute_address.swarm-mng-int.address}:/home/docker-user/token .",
      "sudo docker swarm join --token $(cat /home/docker-user/token) ${google_compute_address.swarm-mng-int.address}:2377",

      # update labels for current node
      "ssh -o StrictHostKeyChecking=no -o NoHostAuthenticationForLocalhost=yes -o UserKnownHostsFile=/dev/null -i /home/docker-user/key.pem docker-user@${google_compute_address.swarm-mng-int.address} 'sudo docker node update --label-add role=worker swarm-wrk-01'",

      "ssh -o StrictHostKeyChecking=no -o NoHostAuthenticationForLocalhost=yes -o UserKnownHostsFile=/dev/null -i /home/docker-user/key.pem docker-user@${google_compute_address.swarm-mng-int.address} 'sudo docker node update --label-add node=worker-01 swarm-wrk-01'",
      "sudo sysctl -w vm.max_map_count=262144" #for elasticsearch
    ]
  }
}

resource "google_compute_instance" "swarm-wrk-02" {
  name         = "swarm-wrk-02"
  machine_type = "${var.wrk_machine_type}"
  tags         = ["${var.instance_tag}"]
  depends_on   = ["google_compute_instance.swarm-mng"]

  metadata {
    ssh-keys = "docker-user:${file(var.public_key)}"
  }

  boot_disk {
    initialize_params {
      size  = "${var.wrk_disk_size}"
      image = "${var.wrk_disk_image}"
    }
  }

  network_interface {
    network = "${var.network}"

    access_config {
      nat_ip = "${google_compute_address.swarm-wrk-ext-02.address}"
    }

    address = "${google_compute_address.swarm-wrk-int-02.address}"
  }

  connection {
    user = "docker-user"

    # key_file = "ssh/key"
  }

  provisioner "file" {
    source      = "${var.ssh_key_private}"
    destination = "/home/docker-user/key.pem"
  }

  provisioner "remote-exec" {
    inline = [
      "sudo apt-get update",
      "sudo apt-get install -y apt-transport-https ca-certificates curl software-properties-common",
      "curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -",
      "sudo add-apt-repository 'deb [arch=amd64] https://download.docker.com/linux/ubuntu bionic stable'",
      "sudo apt-get update",
      "apt-cache policy docker-ce",
      "sudo apt install -y docker-ce",
      "sudo systemctl enable docker",
      "sudo systemctl start docker",
      "sudo chmod 400 /home/docker-user/key.pem",
      "sudo scp -o StrictHostKeyChecking=no -o NoHostAuthenticationForLocalhost=yes -o UserKnownHostsFile=/dev/null -i /home/docker-user/key.pem docker-user@${google_compute_address.swarm-mng-int.address}:/home/docker-user/token .",
      "sudo docker swarm join --token $(cat /home/docker-user/token) ${google_compute_address.swarm-mng-int.address}:2377",

      # update labels for current node
      "ssh -o StrictHostKeyChecking=no -o NoHostAuthenticationForLocalhost=yes -o UserKnownHostsFile=/dev/null -i /home/docker-user/key.pem docker-user@${google_compute_address.swarm-mng-int.address} 'sudo docker node update --label-add role=worker swarm-wrk-02'",

      "ssh -o StrictHostKeyChecking=no -o NoHostAuthenticationForLocalhost=yes -o UserKnownHostsFile=/dev/null -i /home/docker-user/key.pem docker-user@${google_compute_address.swarm-mng-int.address} 'sudo docker node update --label-add node=worker-02 swarm-wrk-02'",
      "sudo sysctl -w vm.max_map_count=262144" #for elasticsearch

    ]
  }
}