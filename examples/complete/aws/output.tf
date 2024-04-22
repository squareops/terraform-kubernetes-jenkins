output "jenkins_credentials" {
  description = "Information about the Jenkins instance, including the username, password, and URL."
  value       = module.jenkins.jenkins
}
