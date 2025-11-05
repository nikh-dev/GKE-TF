variable "project" {
  type = string
}

variable "region" {
  type = string
  default = "us-central1"
}

variable "zone" {
  type    = string
  default = "us-central1-a"
}

variable "credentials" {
    type = string
}

variable "cluster_name" {
  type = string
  default = "tf-gke-demo"
}

variable "network" {
  type = string
  default = "default"
}

variable "initial_node_count" {
  type = number
  default = 2
}

variable "node_pool_min" {
  type = number
  default = 1
}

variable "node_pool_max" {
  type = number
  default = 5
}
