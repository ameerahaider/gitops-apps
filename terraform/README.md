# DigitalOcean Kubernetes (DOKS) via Terraform

This infrastructure is broken down into modular components to make it easier to maintain and reuse.

### 🧩 Files Matrix
- **[`providers.tf`](./providers.tf)**: Configures DigitalOcean, Kubernetes, and Helm.
- **[`variables.tf`](./variables.tf)**: Defines the required inputs like `do_token` and `region`.
- **[`cluster.tf`](./cluster.tf)**: Provisions the Kubernetes cluster (`main-cluster`) and creates the `web` namespace.
- **[`database.tf`](./database.tf)**: Provisions a managed PostgreSQL cluster and creates a Kubernetes secret with connection URIs.
- **[`registry.tf`](./registry.tf)**: Provisions a private Docker registry and configures Kubernetes pull secrets.
- **[`argocd.tf`](./argocd.tf)**: Installs ArgoCD into the cluster via Helm to enable the GitOps workflow.

---

### 🚀 Usage Guide

#### 1. Configuration
Create a file named `terraform.tfvars` in this directory:
```hcl
do_token = "your_digitalocean_token_here"
```

#### 2. Deployment
```bash
terraform init
terraform plan
terraform apply
```

#### 3. Output Secrets
Once applied, you can retrieve the cluster's kubeconfig directly:
```bash
doctl kubernetes cluster kubeconfig save main-cluster
```

---

### 🔍 How Connection Secrets are Shared
A key feature of this repo is the **cross-provider secret management**:
-   Terraform grabs the `uri` from the **DigitalOcean Database** provider.
-   It then passes that `uri` into a **Kubernetes Secret** (`db-credentials`) in the `web` namespace.
-   Finally, the **ArgoCD Manifests** in `infrastructure/gitops-manifests` reference this secret as an environment variable (`DATABASE_URL`) for the Node.js pods.

This creates a seamless link between cloud resources and containerized apps without hardcoding secrets.
