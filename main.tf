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


#Created a jenkins backup cronjob, internally uses jenkins master pvc to make a zip file and upload it to s3.
#To use this please create a S3 bucket and pass the name of the bucket along with other varaibles.
resource "kubernetes_cron_job_v1" "jenkins_backup_cron" {
  depends_on = [kubernetes_namespace.jenkins]
  count = var.jenkins_config.backup  ? 1 : 0
  metadata {
    name      = "jenkins-backup-cron"
    namespace = "jenkins"
  }
  spec {
    schedule = "0 6 * * *"  # Runs the job every day at 6 AM
    job_template {
      metadata {
        name = "jenkins-backup-job"
      }
      spec {
        template {
          metadata {}
          spec {
            container {
              name    = "jenkins-backup"
              image   = "amazonlinux"
              command = ["/bin/bash", "-c"]
              args = [ 
                "${templatefile("${path.module}/backup.sh", {
                backup_bucket_name = var.jenkins_config.backup_bucket_name
              })}" ]
              volume_mount {
                name       = "jenkins-home"
                mount_path = "/var/jenkins_home"
              }
              volume_mount {
                name       = "backup"
                mount_path = "/backup"
              }
            }
            restart_policy = "Never"
            volume {
              name = "jenkins-home"
              persistent_volume_claim {
                claim_name = "jenkins" 
              }
            }
            volume {
              name = "backup"
              empty_dir {}
            }
          }
        }
      }
    }
  }
}


# Creating a pod for jenkins restore, which will get the backup.zip from S3 and overwrite the content to jenkins home directory.
# Always restart jenkisn to reflect the changes.
resource "kubernetes_pod" "jenkins_restore" {
  depends_on = [kubernetes_namespace.jenkins]
  count = var.jenkins_config.restore_backup ? 1 : 0
  metadata {
    name      = "jenkins-restore"
    namespace = "jenkins"
  }
  spec {
    container {
      name    = "jenkins-restore"
      image   = "amazonlinux"
      command = ["/bin/bash", "-c"]
      args = [ 
        "${templatefile("${path.module}/restore.sh", {
        backup_bucket_name = var.jenkins_config.backup_bucket_name,
        restore_object_path = var.jenkins_config.restore_object_path
      })}" ]
      volume_mount {
        name      = "jenkins-home"
        mount_path = "/var/jenkins_home"
      }
      volume_mount {
        name      = "restore"
        mount_path = "/restore"
      }
    }

    restart_policy = "Never"
    volume {
      name = "jenkins-home"
      persistent_volume_claim {
        claim_name = "jenkins"
      }
    }
    volume {
      name = "restore"
      empty_dir {}
    }
  }
}
