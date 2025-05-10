provider "google" {
  credentials = file("path-to-your-sa-key.json")
  project     = var.project_id
  region      = var.region
}

resource "google_compute_network" "vpc_network" {
  name = "hello-vpc"
}

resource "google_container_cluster" "gke_cluster" {
  name     = "hello-gke"
  location = var.region
  initial_node_count = 1

  node_config {
    machine_type = "e2-medium"
    oauth_scopes = ["https://www.googleapis.com/auth/cloud-platform"]
  }

  autoscaling {
    enabled         = true
    min_node_count  = 1
    max_node_count  = 3
  }

  network = google_compute_network.vpc_network.name
}