locals {
  name        = "grafana"
  region      = "us-east-1"
  environment = "testing"
  additional_tags = {
    Owner      = "organization_name"
    Expires    = "Never"
    Department = "Engineering"
  }
  oidc_provider = replace(
    data.aws_eks_cluster.cluster.identity[0].oidc[0].issuer,
    "/^https:///",
    ""
  )
}

data "aws_caller_identity" "current" {}


module "s3_bucket_jenkins_backup" {
  source                   = "terraform-aws-modules/s3-bucket/aws"
  version                  = "4.1.2"
  create_bucket            = true
  bucket                   = format("%s-%s-%s", local.environment, local.name, "jenkins-backup")
  acl                      = "private"
  control_object_ownership = true
  object_ownership         = "ObjectWriter"

  versioning = {
    enabled = true
  }
  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

resource "aws_iam_role" "jenkins_backup_role" {
  depends_on = [module.s3_bucket_jenkins_backup]
  name       = format("%s-%s-%s", local.environment, local.name, "jenkins-backup-role")
  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect = "Allow",
        Principal = {
          Federated = "arn:aws:iam::${data.aws_caller_identity.current.account_id}:oidc-provider/${local.oidc_provider}"
        },
        Action = "sts:AssumeRoleWithWebIdentity",
        Condition = {
          StringEquals = {
            "${local.oidc_provider}:aud" = "sts.amazonaws.com",
            "${local.oidc_provider}:sub" = "system:serviceaccount:jenkins:sa-jenkins"
          }
        }
      }
    ]
  })
  inline_policy {
    name = "AllowS3PutObject"
    policy = jsonencode({
      Version = "2012-10-17"
      Statement = [
        {
          Action = [
            "kms:DescribeCustomKeyStores",
            "kms:ListKeys",
            "kms:DeleteCustomKeyStore",
            "kms:GenerateRandom",
            "kms:UpdateCustomKeyStore",
            "kms:ListAliases",
            "kms:DisconnectCustomKeyStore",
            "kms:CreateKey",
            "kms:ConnectCustomKeyStore",
            "kms:CreateCustomKeyStore"
          ]
          Effect   = "Allow"
          Resource = "*"
        },
        {
          "Effect" : "Allow",
          "Action" : [
            "s3:*",
            "s3-object-lambda:*"
          ],
          "Resource" : "*"
        }
      ]
    })
  }
}

resource "kubernetes_service_account" "sa_jenkins" {
  metadata {
    name      = "sa-jenkins"
    namespace = "jenkins"
    annotations = {
      "eks.amazonaws.com/role-arn" = aws_iam_role.jenkins_backup_role.arn
    }
  }
}

module "jenkins" {
  source     = "../../../"
  depends_on = [module.s3_bucket_jenkins_backup]
  jenkins_config = {
    hostname            = "jenk.rnd.squareops.in"
    values_yaml         = file("./helm/values.yaml")
    storage_class_name  = "infra-service-sc"
    jenkins_volume_size = "10Gi"
    enable_backup       = true                                                   # true for enable backup
    backup_schedule     = "0 6 * * *"                                            # Set Cron for the job
    service_account     = kubernetes_service_account.sa_jenkins.metadata[0].name # service account name
    backup_bucket_name  = module.s3_bucket_jenkins_backup.s3_bucket_id           # s3 bucket name
    restore_backup      = true                                                   # true for restore the backup
    backup_restore_date = "2024-07-18"                                           # Date of backup
  }
}
