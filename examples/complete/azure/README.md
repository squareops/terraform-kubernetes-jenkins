# Azure Jenkins Terraform Kubernetes Module
<!-- BEGIN_TF_DOCS -->
## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | n/a |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_jenkins"></a> [jenkins](#module\_jenkins) | https://github.com/sq-ia/terraform-kubernetes-jenkins.git | n/a |

## Resources

| Name | Type |
|------|------|
| [azurerm_kubernetes_cluster.primary](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/kubernetes_cluster) | data source |

## Inputs

No inputs.

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_jenkins_credentials"></a> [jenkins\_credentials](#output\_jenkins\_credentials) | Jenkins\_Info |
<!-- END_TF_DOCS -->