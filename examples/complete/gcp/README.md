# GCP Jenkins Terraform Kubernetes Module

<!-- BEGIN_TF_DOCS -->
## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_google"></a> [google](#provider\_google) | n/a |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_jenkins"></a> [jenkins](#module\_jenkins) | https://github.com/sq-ia/terraform-kubernetes-jenkins.git | n/a |

## Resources

| Name | Type |
|------|------|
| [google_client_config.default](https://registry.terraform.io/providers/hashicorp/google/latest/docs/data-sources/client_config) | data source |
| [google_container_cluster.primary](https://registry.terraform.io/providers/hashicorp/google/latest/docs/data-sources/container_cluster) | data source |

## Inputs

No inputs.

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_jenkins_credentials"></a> [jenkins\_credentials](#output\_jenkins\_credentials) | Jenkins\_Info |
<!-- END_TF_DOCS -->