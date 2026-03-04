# 4. Managed PostgreSQL (DigitalOcean Database)
#
# Instead of running Postgres inside Kubernetes, 
# we use DO's managed service for backups and scaling.
resource "digitalocean_database_cluster" "postgres" {
  name       = "${var.project_name}-db"
  engine     = "pg"
  version    = "15"
  size       = "db-s-1vcpu-1gb" # Entry-level plan for portfolio demos.
  region     = var.region
  node_count = 1
}

# Kubernetes Secret: database connection details.
# This exports the managed DB connection values into a K8s secret 
# in the `web` namespace so the application can read them.
resource "kubernetes_secret" "db_creds" {
  metadata {
    name      = "db-credentials"
    namespace = kubernetes_namespace_v1.namespace.metadata[0].name
  }

  data = {
    host     = digitalocean_database_cluster.postgres.host
    port     = digitalocean_database_cluster.postgres.port
    user     = digitalocean_database_cluster.postgres.user
    password = digitalocean_database_cluster.postgres.password
    database = digitalocean_database_cluster.postgres.database
    uri      = digitalocean_database_cluster.postgres.uri
  }

  type = "Opaque"
}
