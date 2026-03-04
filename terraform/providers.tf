terraform {
  required_version = ">= 1.5.0"

  required_providers {
    digitalocean = {
      source  = "digitalocean/digitalocean"
      version = "~> 2.34"
    }
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "~> 2.24"
    }
    helm = {
      source  = "hashicorp/helm"
      version = "~> 2.12"
    }
  }
}

# The DigitalOcean provider uses the token from variables.
provider "digitalocean" {
  token = var.do_token
}

# The Kubernetes provider connects to the cluster using the 
# data source defined in cluster.tf.
provider "kubernetes" {
  host                   = data.digitalocean_kubernetes_cluster.primary.endpoint
  token                  = data.digitalocean_kubernetes_cluster.primary.kube_config[0].token
  cluster_ca_certificate = base64decode(data.digitalocean_kubernetes_cluster.primary.kube_config[0].cluster_ca_certificate)
}

# The Helm provider uses the same cluster credentials.
provider "helm" {
  kubernetes {
    host                   = data.digitalocean_kubernetes_cluster.primary.endpoint
    token                  = data.digitalocean_kubernetes_cluster.primary.kube_config[0].token
    cluster_ca_certificate = base64decode(data.digitalocean_kubernetes_cluster.primary.kube_config[0].cluster_ca_certificate)
  }
}

