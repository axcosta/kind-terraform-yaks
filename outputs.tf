output "yaks_info" {
  description = "Information about the YAKS instance created on K8S cluster"
  value = {
    instance = {
        name        = var.apps["yaks"].instance.name
        namespace   = var.apps["yaks"].instance.namespace
    }    
  }
}
# output "resources" {
#   value = data.kubernetes_resources.resources
# }
