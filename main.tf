resource "kubernetes_namespace" "jenkins" {
  metadata {
    name = var.namespace
  }
}

resource "helm_release" "jenkins" {
  depends_on = [kubernetes_namespace.jenkins]
  name       = "jenkins"
  chart      = "jenkins"
  timeout    = 600
  version    = var.chart_version
  namespace  = var.namespace
  repository = "https://charts.jenkins.io/"
  values = [
    templatefile("${path.module}/helm/values.yaml", {
      hostname            = var.jenkins_config.hostname
      storage_class_name  = var.jenkins_config.storage_class_name
      jenkins_volume_size = var.jenkins_config.jenkins_volume_size
    }),
    var.jenkins_config.values_yaml
  ]
}

data "kubernetes_secret" "jenkins" {
  depends_on = [helm_release.jenkins]
  metadata {
    name      = "jenkins"
    namespace = var.namespace
  }
}
