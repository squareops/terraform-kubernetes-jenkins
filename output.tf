output "jenkins_password" {
  description = "password"
  value       = nonsensitive(data.kubernetes_secret.jenkins.data["jenkins-admin-password"])
}

output "jenkins_user" {
  description = "user"
  value       = nonsensitive(data.kubernetes_secret.jenkins.data["jenkins-admin-user"])
}
