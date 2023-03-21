## JENKINS


variable "jenkins_config" {
  type = any
  default = {
    hostname            = ""
    storage_class_name  = ""
    jenkins_volume_size = ""
    values_yaml         = ""
  }
  description = "Jenkins configurations"
}

variable "namespace" {
  type        = string
  default     = "jenkins"
  description = "Namespace name"
}

variable "chart_version" {
  type        = string
  default     = "4.2.15"
  description = "Chart Version"
}
