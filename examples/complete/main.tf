locals {
  region      = "us-east-2"
  name        = "skaf"
  environment = "prod"
}

module "jenkins" {
  source = "../.."
  jenkins_config = {
    hostname            = "jenkin.ref.dev.skaf.squareops.in"
    values_yaml         = file("./helm/values.yaml")
    storage_class_name  = "gp2"
    jenkins_volume_size = "10Gi"
  }
}
