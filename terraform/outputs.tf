output "cluster_endpoint" {
  value       = digitalocean_kubernetes_cluster.primary.endpoint
  description = "The endpoint for your DigitalOcean Kubernetes cluster."
}

output "registry_endpoint" {
  value       = digitalocean_container_registry.registry.endpoint
  description = "Your private DOCR endpoint."
}

output "registry_name" {
  value       = digitalocean_container_registry.registry.name
  description = "Your private DOCR name."
}

output "database_host" {
  value       = digitalocean_database_cluster.postgres.host
  description = "Your private DOCR host."
  sensitive   = true
}

output "database_uri" {
  value       = digitalocean_database_cluster.postgres.uri
  description = "Your private DOCR URI."
  sensitive   = true
}
