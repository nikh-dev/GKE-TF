variable "project" {
  type = string
}

variable "region" {
  type = string
  default = ""
}

variable "zone" {
  type    = string
  default = ""
}

variable "credentials" {
    type = string
}

variable "cluster_name" {
  type = string
  default = ""
}

variable "network" {
  type = string
  default = ""
}

variable "initial_node_count" {
  type = number
  default = 
}

variable "node_pool_min" {
  type = number
  default = 
}

variable "node_pool_max" {
  type = number
  default = 
}

