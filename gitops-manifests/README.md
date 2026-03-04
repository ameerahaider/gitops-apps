# ArgoCD & GitOps Manifests: CD Operations

This directory contains the declarative **Kubernetes Manifests** (YAML files) that define our application's state inside the cluster. Our GitOps engine (**ArgoCD**) watches these files; any change here is automatically synced to the cluster.

### 🧩 Core Components in This Folder
1.  **Backend Deployment & Service (`backend-api.yaml`)**:
    -   **Deployment**: Manages 1 replica of our `backend:latest` container.
    -   **Service**: A stable internal DNS name (`backend-service`) so the frontend can reach the API.
    -   **Env / Secrets**: Reads `DATABASE_URL` from the Kubernetes secret (`db-credentials`) created via Terraform.
2.  **Frontend Deployment & Service (`frontend-web.yaml`)**:
    -   **Deployment**: Serves our React dashboard.
    -   **Service**: A `ClusterIP` service to keep the frontend private within the cluster.
3.  **Ingress Controller (`ingress.yaml`)**:
    -   **The Entry Point**: Configures an NGINX Ingress Controller.
    -   **Routing Rules**:
        -   Traffic to `/api` is routed to the `backend-service`.
        -   All other traffic (`/`) is routed to the `frontend-service`.

### 🔄 The GitOps Workflow (How CD Works)
1.  **Modify YAML**: You edit a manifest file (e.g., increase `replicas: 1` to `replicas: 3`).
2.  **Push to Git**: You commit and push the change to GitHub.
3.  **ArgoCD Reconciles**: ArgoCD detects the discrepancy between Git (3 replicas) and the Cluster (1 replica) and **syncs** the cluster to match Git automatically.

---

### 🔍 Deep Dive: Kubernetes Resources Explained

#### **Deployments**
-   **Image Pull Secrets**: We specify `task-manager-registry-secret` so Kubernetes can authenticate with our private DigitalOcean Registry.
-   **Liveness/Readiness**: (Future improvement) You can add health checks here to ensure Kubernetes only sends traffic to healthy pods.

#### **Services**
-   **TargetPort vs. Port**: The `port` is the external-facing port of the Service (usually 80 or 443), while the `targetPort` is what the actual container is listening on (e.g., 5678 for the Backend).

---

> [!IMPORTANT]
> **Production Recommendation**: For a production environment, instead of using the `latest` tag, you should use specific image hashes or semantic version tags (e.g., `v1.2.3`). This ensures that you can roll back to a known stable state.
