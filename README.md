## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_kind"></a> [kind](#requirement\_kind) | 0.0.13 |
| <a name="requirement_kubectl"></a> [kubectl](#requirement\_kubectl) | 1.14.0 |
| <a name="requirement_time"></a> [time](#requirement\_time) | 0.9.1 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_http"></a> [http](#provider\_http) | 3.2.1 |
| <a name="provider_kind"></a> [kind](#provider\_kind) | 0.0.13 |
| <a name="provider_kubectl"></a> [kubectl](#provider\_kubectl) | 1.14.0 |
| <a name="provider_time"></a> [time](#provider\_time) | 0.9.1 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [kind_cluster.lab_k8s_cluster](https://registry.terraform.io/providers/tehcyx/kind/0.0.13/docs/resources/cluster) | resource |
| [kubectl_manifest.olm_crds_manifests](https://registry.terraform.io/providers/gavinbunney/kubectl/1.14.0/docs/resources/manifest) | resource |
| [kubectl_manifest.olm_olm_manifests](https://registry.terraform.io/providers/gavinbunney/kubectl/1.14.0/docs/resources/manifest) | resource |
| [kubectl_manifest.yaks_instance](https://registry.terraform.io/providers/gavinbunney/kubectl/1.14.0/docs/resources/manifest) | resource |
| [kubectl_manifest.yaks_operator_subscription](https://registry.terraform.io/providers/gavinbunney/kubectl/1.14.0/docs/resources/manifest) | resource |
| [time_sleep.wait_operator_to_be_created](https://registry.terraform.io/providers/hashicorp/time/0.9.1/docs/resources/sleep) | resource |
| [http_http.olm_yamls](https://registry.terraform.io/providers/hashicorp/http/latest/docs/data-sources/http) | data source |
| [kubectl_file_documents.manifests](https://registry.terraform.io/providers/gavinbunney/kubectl/1.14.0/docs/data-sources/file_documents) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_apps"></a> [apps](#input\_apps) | n/a | `map` | <pre>{<br>  "olm": {<br>    "yamls": {<br>      "crds": "https://raw.githubusercontent.com/operator-framework/operator-lifecycle-manager/master/deploy/upstream/quickstart/crds.yaml",<br>      "olm": "https://raw.githubusercontent.com/operator-framework/operator-lifecycle-manager/master/deploy/upstream/quickstart/olm.yaml"<br>    }<br>  },<br>  "yaks": {<br>    "instance": {<br>      "name": "yaks",<br>      "namespace": "operators",<br>      "operator": {<br>        "global": false,<br>        "namespace": "operators"<br>      },<br>      "yaml_path": "apps/yaks/instance.yaml"<br>    },<br>    "subscription": {<br>      "channel": "alpha",<br>      "name": "yaks-poc",<br>      "namespace": "operators",<br>      "operator": {<br>        "name": "yaks",<br>        "source": {<br>          "name": "operatorhubio-catalog",<br>          "namespace": "olm"<br>        }<br>      },<br>      "time_to_wait": "90s",<br>      "yaml_path": "apps/yaks/subscription.yaml"<br>    }<br>  }<br>}</pre> | no |
| <a name="input_cluster"></a> [cluster](#input\_cluster) | n/a | `map` | <pre>{<br>  "api_version": "kind.x-k8s.io/v1alpha4",<br>  "name": "kind-lab-k8s-cluster",<br>  "node_image": "kindest/node:v1.24.0"<br>}</pre> | no |
| <a name="input_kubernetes_resources"></a> [kubernetes\_resources](#input\_kubernetes\_resources) | n/a | `map` | <pre>{<br>  "instance": {<br>    "api_version": "yaks.citrusframework.org/v1alpha1",<br>    "kind": "Instance"<br>  },<br>  "subscription": {<br>    "api_version": "operators.coreos.com/v1alpha1",<br>    "kind": "Subscription"<br>  }<br>}</pre> | no |
| <a name="input_terraform_managed_by_label"></a> [terraform\_managed\_by\_label](#input\_terraform\_managed\_by\_label) | n/a | `map` | <pre>{<br>  "app.kubernetes.io/managed-by": "terraform"<br>}</pre> | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_yaks_info"></a> [yaks\_info](#output\_yaks\_info) | n/a |
