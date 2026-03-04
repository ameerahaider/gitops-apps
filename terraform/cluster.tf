# 1. DigitalOcean Kubernetes (DOKS)
#
# This creates a managed Kubernetes cluster. 
# Managed means DigitalOcean handles the control plane 
# while we define the worker nodes (the VMs).
resource "digitalocean_kubernetes_cluster" "primary" {
  name    = var.cluster_name
  region  = var.region
  version = var.k8s_version

  node_pool {
    name       = "worker-pool"
    size       = "s-2vcpu-2gb" # Balancing cost and CPU power.
    node_count = 1             # 1 node for simplicity.
  }
}

# Data source: retrieve the cluster credentials created above.
# This is used by other provider blocks (Kubernetes, Helm).
data "digitalocean_kubernetes_cluster" "primary" {
  name = digitalocean_kubernetes_cluster.primary.name
}

# Defines a logical group for all application resources.
resource "kubernetes_namespace_v1" "namespace" {
  metadata {
    name = var.namespace
  }
}
