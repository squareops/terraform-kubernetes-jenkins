output "jenkins" {
  description = "Information about the Jenkins instance, including the username, password, and URL."
  value = {
    username = nonsensitive(data.kubernetes_secret.jenkins.data["jenkins-admin-user"]),
    password = nonsensitive(data.kubernetes_secret.jenkins.data["jenkins-admin-password"]),
    url      = var.jenkins_config.hostname
  }
}
