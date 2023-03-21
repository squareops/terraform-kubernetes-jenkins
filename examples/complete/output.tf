output "jenkins_password" {
  description = "password"
  value       = module.jenkins.jenkins_password
}

output "jenkins_user" {
  description = "username"
  value       = module.jenkins.jenkins_user
}
