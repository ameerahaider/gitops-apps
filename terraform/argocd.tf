# 2. Helm Installation: ArgoCD
#
# ArgoCD is our "GitOps" controller. This installs ArgoCD using its 
# official Helm chart to prepare the cluster for automated deployment.
resource "helm_release" "argocd" {
  name             = "argocd"
  repository       = "https://argoproj.github.io/argo-helm"
  chart            = "argo-cd"
  namespace        = "argocd"
  create_namespace = true
  version          = "5.46.0"
}
