resource "google_container_cluster" "primary" {
  name     = var.cluster_name
  location = var.zone

  remove_default_node_pool = true
  initial_node_count = 1

  network = var.network
  deletion_protection=false
}


resource "google_container_node_pool" "primary_nodes" {
  name       = "primary-node-pool"
  cluster    = google_container_cluster.primary.name
  location   = var.zone
  initial_node_count = var.initial_node_count

  autoscaling {
    min_node_count = var.node_pool_min
    max_node_count = var.node_pool_max
  }

  

  node_config {
    machine_type = "e2-medium"
  }
}
