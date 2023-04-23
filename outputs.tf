output "yaks_info" {
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
