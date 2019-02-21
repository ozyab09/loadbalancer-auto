terraform {
  backend "gcs" {
    bucket = "load-balancer"
    prefix = "state"
    credentials = "/root/serviceaccount.json"
  }
}
