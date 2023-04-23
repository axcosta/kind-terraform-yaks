# data "kubernetes_resources" "resources" {
#     for_each    = var.kubernetes_resources
#     api_version = each.value.api_version
#     kind        = each.value.kind
#     depends_on  = [
#       kubectl_manifest.yaks_instance
#     ]
# }
# resource "kubernetes_labels" "resources_labels" {
#     for_each    = data.kubernetes_resources.resources
#     api_version = each.value.api_version
#     kind        = each.value.kind
#     labels      = var.terraform_managed_by_label
# }