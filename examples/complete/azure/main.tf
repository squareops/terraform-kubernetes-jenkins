locals {
  name        = "jenkins"
  region      = "eastus"
  environment = "prod"
  additional_tags = {
    Owner      = "organization_name"
    Expires    = "Never"
    Department = "Engineering"
  }
}

module "jenkins" {
  source = "https://github.com/sq-ia/terraform-kubernetes-jenkins.git"
  jenkins_config = {
    hostname            = "jenkins.squareops.in"
    values_yaml         = file("./helm/values.yaml")
    storage_class_name  = "infra-service-sc"
    jenkins_volume_size = "10Gi"
  }
}
