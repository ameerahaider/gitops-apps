# 3. DigitalOcean Container Registry (DOCR)
#
# A private registry for our Docker images.
resource "digitalocean_container_registry" "registry" {
  name                   = "${var.project_name}-registry"
  subscription_tier_slug = "basic" # inexpensive tier
  region                 = var.region
}

# Docker credentials for the registry.
# Generates a base64-encoded credential blob.
resource "digitalocean_container_registry_docker_credentials" "registry_creds" {
  registry_name = digitalocean_container_registry.registry.name
}

# Kubernetes Secret: Docker Registry credentials.
# Stores the `.dockerconfigjson` in a Secret so pods can pull private images.
resource "kubernetes_secret" "docker_registry_creds" {
  metadata {
    name      = "${var.project_name}-registry-secret"
    namespace = kubernetes_namespace_v1.namespace.metadata[0].name
  }

  data = {
    ".dockerconfigjson" = digitalocean_container_registry_docker_credentials.registry_creds.docker_credentials
  }

  type = "kubernetes.io/dockerconfigjson"
}
