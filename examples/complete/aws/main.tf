locals {
  name        = "jenkins"
  region      = "us-east-2"
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
    hostname            = "jenkin.squareops.in"
    values_yaml         = file("./helm/values.yaml")
    storage_class_name  = "infra-service-sc"
    jenkins_volume_size = "10Gi"
    backup              = true
    backup_bucket_name  = "jenkins-backup-bucket"
    restore_backup      = false
    restore_object_path = "s3://jenkins-backup-bucket/2024-06-18/backup.zip"
  }
}
