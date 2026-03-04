variable "do_token" {
  description = "DigitalOcean API Token"
  type        = string
  sensitive   = true
}

variable "region" {
  description = "Region for DigitalOcean resources"
  type        = string
  default     = "nyc3"
}

variable "cluster_name" {
  description = "Name of the Kubernetes cluster"
  type        = string
  default     = "main-cluster"
}

variable "project_name" {
  description = "Name of the Project"
  type        = string
  default     = "personality-simulation-engine"
}

variable "namespace" {
  description = "Namespace for the application"
  type        = string
  default     = "personality-simulation-engine-app"
}

variable "k8s_version" {
  description = "Kubernetes version for DOKS"
  type        = string
  default     = "1.34.1-do.5"
}

variable "registry_name" {
  description = "Name of the DigitalOcean container registry"
  type        = string
  default     = "personality-simulation-engine-registry"
}

variable "db_name" {
  description = "Name of the database cluster"
  type        = string
  default     = "personality-simulation-engine-db"
}
