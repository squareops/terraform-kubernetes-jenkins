variable "additional_aws_tags" {
  description = "Additional tags to be applied to resources"
  type        = map(string)
  default     = {}
}

variable "jenkins_config" {
  description = "Specify the configuration settings for Jenkins, including the hostname, storage options, and custom YAML values."
  type        = any
  default = {
    hostname            = ""
    storage_class_name  = ""
    jenkins_volume_size = ""
    values_yaml         = ""
  }
}

variable "namespace" {
  description = "Name of the Kubernetes namespace where the Jenkins deployment will be deployed."
  type        = string
  default     = "jenkins"
}

variable "helm_chart_version" {
  description = "Version of the Jenkins chart that will be used to deploy Jenkins application."
  type        = string
  default     = "5.1.3"
}
