locals {
  name        = "jenkins"
  region      = "ap-northeast-1"
  environment = "stg"
  additional_aws_tags = {
    Owner      = "organization_name"
    Expires    = "Never"
    Department = "Engineering"
  }
}

module "jenkins" {
  # source = "https://github.com/sq-ia/terraform-kubernetes-jenkins.git"
  source = "../../../"
  jenkins_config = {
    hostname            = "jenkins.test.atmosly.in"
    values_yaml         = file("./helm/values.yaml")
    storage_class_name  = "infra-service-sc"
    jenkins_volume_size = "10Gi"
  }
}
