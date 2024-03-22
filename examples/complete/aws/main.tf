locals {
  name        = "jenkins"
  region      = "us-east-2"
  environment = "dev"
  additional_tags = {
    Owner      = "organization_name"
    Expires    = "Never"
    Department = "Engineering"
  }
}

module "jenkins" {
  source = "../../../"
  jenkins_config = {
    hostname            = "jenkins.ldc.squareops.in"
    values_yaml         = file("./helm/values.yaml")
    storage_class_name  = "infra-service-sc"
    jenkins_volume_size = "10Gi"
  }
}
