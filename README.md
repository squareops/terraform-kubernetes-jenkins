## Jenkins

![squareops_avatar]

[squareops_avatar]: https://squareops.com/wp-content/uploads/2022/12/squareops-logo.png

### [SquareOps Technologies](https://squareops.com/) Your DevOps Partner for Accelerating cloud journey.
<br>

This module allows you to run Jenkins inside a cluster, providing improved availability and scalability, which can help manage the deployment, scaling, and configuration of Jenkins.
To use this module, you will need to ensure that your cluster is set up correctly, with shared storage for data persistence and load balancing configured to distribute requests across nodes.
Monitoring and logging tools should be used to keep track of Jenkins' health and performance inside the cluster, and to identify any issues that may arise.

## Important Notes:
This module is compatible with EKS, AKS & GKE which is great news for users deploying the module on an AWS, Azure & GCP cloud. Review the module's documentation, meet specific configuration requirements, and test thoroughly after deployment to ensure everything works as expected.

## Supported Versions:

|  Jenkins Helm Chart Version    |     K8s supported version (EKS, AKS & GKE)  |  
| :-----:                       |         :---                |
| **4.2.15**                     |    **1.23,1.24,1.25,1.26,1.27**           |
| **4.5.0**                     |    **1.23,1.24,1.25,1.26,1.27**           |
| **5.2.2**                     |    **1.23,1.24,1.25,1.26,1.27,1.28,1.29,1.30**           |
| **5.4.2**                     |    **1.23,1.24,1.25,1.26,1.27,1.28,1.29,1.30**           |


## Usage Example

```hcl
module "jenkins" {
  source        = "https://github.com/sq-ia/terraform-kubernetes-jenkins.git"
  jenkins_config = {
    hostname            = "jenkins.squareops.in"
    values_yaml         = file("./helm/values.yaml")
    storage_class_name  = "infra-service-sc"
    jenkins_volume_size = "10Gi"
    enable_backup       = true   # true for enable backup
    backup_schedule     = "0 6 * * *" # Set Cron for the job
    service_account     = kubernetes_service_account.sa_jenkins.metadata[0].name # service account name
    backup_bucket_name  = module.s3_bucket_jenkins_backup.s3_bucket_id  # s3 bucket name
    restore_backup      = true # true for restore the backup
    backup_restore_date = "2024-07-18" # Date of backup
  }
}

```
- Refer [AWS examples](https://github.com/sq-ia/terraform-kubernetes-jenkins/tree/main/examples/complete/aws) for more details.
- Refer [Azure examples](https://github.com/sq-ia/terraform-kubernetes-jenkins/tree/main/examples/complete/azure) for more details.
- Refer [GCP examples](https://github.com/sq-ia/terraform-kubernetes-jenkins/tree/main/examples/complete/gcp) for more details.

## IAM Permissions
The required IAM permissions to create resources from this module can be found [here](https://github.com/sq-ia/terraform-kubernetes-jenkins/blob/main/IAM.md)


## Backup and Restore
This repository provides a method for backing up and restoring Jenkins using S3 storage.

<b>Usage</b> <br>
To enable backup, set the <b>enable_backup</b> variable to true. Backups will be automatically stored in the configured S3 bucket.

To restore a backup, set the <b>restore_backup</b> variable to true. This will initiate the restoration process from the latest backup available in the S3 bucket.

<b>Important Notes</b> <br>
<ul><li>Ensure to restart the Jenkins service after performing a restore to apply the restored configuration and data.</li>
<li>Backup and restore functionality relies on proper configuration of S3 credentials and bucket permissions.</li></ul>



<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | n/a |
| <a name="provider_helm"></a> [helm](#provider\_helm) | n/a |
| <a name="provider_kubernetes"></a> [kubernetes](#provider\_kubernetes) | n/a |
| <a name="provider_time"></a> [time](#provider\_time) | n/a |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_iam_role.jenkins_backup_role](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [helm_release.jenkins](https://registry.terraform.io/providers/hashicorp/helm/latest/docs/resources/release) | resource |
| [kubernetes_cron_job_v1.jenkins_backup_cron](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/cron_job_v1) | resource |
| [kubernetes_namespace.jenkins](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/namespace) | resource |
| [kubernetes_pod.jenkins_restore](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/pod) | resource |
| [kubernetes_service_account.sa_jenkins](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/service_account) | resource |
| [time_sleep.wait_120_sec](https://registry.terraform.io/providers/hashicorp/time/latest/docs/resources/sleep) | resource |
| [aws_caller_identity.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/caller_identity) | data source |
| [kubernetes_secret.jenkins](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/data-sources/secret) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_chart_version"></a> [chart\_version](#input\_chart\_version) | Version of the Jenkins chart that will be used to deploy Jenkins application. | `string` | `"5.4.2"` | no |
| <a name="input_jenkins_config"></a> [jenkins\_config](#input\_jenkins\_config) | Specify the configuration settings for Jenkins, including the hostname, storage options, and custom YAML values. | `any` | <pre>{<br>  "backup_bucket_name": "",<br>  "backup_restore_date": "",<br>  "backup_schedule": "",<br>  "enable_backup": false,<br>  "environment": "",<br>  "hostname": "",<br>  "jenkins_volume_size": "",<br>  "name": "",<br>  "oidc_provider": "",<br>  "restore_backup": false,<br>  "storage_class_name": "",<br>  "values_yaml": ""<br>}</pre> | no |
| <a name="input_namespace"></a> [namespace](#input\_namespace) | Name of the Kubernetes namespace where the Jenkins deployment will be deployed. | `string` | `"jenkins"` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_jenkins"></a> [jenkins](#output\_jenkins) | Jenkins\_Info |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->

## Contribution & Issue Reporting

To report an issue with a project:

  1. Check the repository's [issue tracker](https://github.com/sq-ia/terraform-kubernetes-jenkins/issues) on GitHub
  2. Search to see if the issue has already been reported
  3. If you can't find an answer to your question in the documentation or issue tracker, you can ask a question by creating a new issue. Be sure to provide enough context and details so others can understand your problem.

## License

Apache License, Version 2.0, January 2004 (http://www.apache.org/licenses/).

## Support Us

To support a GitHub project by liking it, you can follow these steps:

  1. Visit the repository: Navigate to the [GitHub repository](https://github.com/sq-ia/terraform-kubernetes-jenkins).

  2. Click the "Star" button: On the repository page, you'll see a "Star" button in the upper right corner. Clicking on it will star the repository, indicating your support for the project.

  3. Optionally, you can also leave a comment on the repository or open an issue to give feedback or suggest changes.

Starring a repository on GitHub is a simple way to show your support and appreciation for the project. It also helps to increase the visibility of the project and make it more discoverable to others.

## Who we are

We believe that the key to success in the digital age is the ability to deliver value quickly and reliably. That’s why we offer a comprehensive range of DevOps & Cloud services designed to help your organization optimize its systems & Processes for speed and agility.

  1. We are an AWS Advanced consulting partner which reflects our deep expertise in AWS Cloud and helping 100+ clients over the last 5 years.
  2. Expertise in Kubernetes and overall container solution helps companies expedite their journey by 10X.
  3. Infrastructure Automation is a key component to the success of our Clients and our Expertise helps deliver the same in the shortest time.
  4. DevSecOps as a service to implement security within the overall DevOps process and helping companies deploy securely and at speed.
  5. Platform engineering which supports scalable,Cost efficient infrastructure that supports rapid development, testing, and deployment.
  6. 24*7 SRE service to help you Monitor the state of your infrastructure and eradicate any issue within the SLA.

We provide [support](https://squareops.com/contact-us/) on all of our projects, no matter how small or large they may be.

To find more information about our company, visit [squareops.com](https://squareops.com/), follow us on [Linkedin](https://www.linkedin.com/company/squareops-technologies-pvt-ltd/), or fill out a [job application](https://squareops.com/careers/). If you have any questions or would like assistance with your cloud strategy and implementation, please don't hesitate to [contact us](https://squareops.com/contact-us/).
