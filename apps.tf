#********************************************************************************#
#                      OLM (Operator Lifecycle Manager)                          #
#********************************************************************************#
data "http" "olm_yamls" {
  for_each  = var.apps["olm"].yamls
  url       = each.value
}
data "kubectl_file_documents" "manifests" {
  for_each  = data.http.olm_yamls
  content   = each.value.response_body
}
resource "kubectl_manifest" "olm_crds_manifests" {
  for_each          = data.kubectl_file_documents.manifests["crds"].manifests
  yaml_body         = each.value
  depends_on        = [    
    kind_cluster.lab_k8s_cluster
  ]
}
resource "kubectl_manifest" "olm_olm_manifests" {
  for_each          = data.kubectl_file_documents.manifests["olm"].manifests
  yaml_body         = each.value
  depends_on        = [        
    kubectl_manifest.olm_crds_manifests
  ]
}
#********************************************************************************#
#                                YAKS                                            #
#********************************************************************************#
resource "kubectl_manifest" "yaks_operator_subscription" {
  yaml_body         = templatefile(var.apps.yaks.subscription.yaml_path, 
    {
      subscription_name               = var.apps["yaks"].subscription.name
      subscription_namespace          = var.apps["yaks"].subscription.namespace
      subscription_channel            = var.apps["yaks"].subscription.channel
      subscription_operator_name      = var.apps["yaks"].subscription.operator.name
      subscription_operator_source    = var.apps["yaks"].subscription.operator.source.name
      subscription_operator_namespace = var.apps["yaks"].subscription.operator.source.namespace
    }
  )
  depends_on        = [
    kubectl_manifest.olm_olm_manifests    
  ]
}
# This is a workaround to wait for YAKS Operator to be created
resource "time_sleep" "wait_operator_to_be_created" {
  depends_on      = [kubectl_manifest.yaks_operator_subscription]
  create_duration = var.apps["yaks"].subscription.time_to_wait
}
resource "kubectl_manifest" "yaks_instance" {
  yaml_body         = templatefile(var.apps.yaks.instance.yaml_path, 
    {
      instance_name             = var.apps["yaks"].instance.name
      instance_namespace        = var.apps["yaks"].instance.namespace
      instance_operator_global  = var.apps["yaks"].instance.operator.global
    }
  )
  depends_on        = [
    time_sleep.wait_operator_to_be_created
  ]
}