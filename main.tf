resource "kind_cluster" "lab_k8s_cluster" {
    name            = var.cluster.name
    node_image      = var.cluster.node_image
    wait_for_ready  = true
    kind_config {
        kind        = "Cluster"
        api_version = var.cluster.api_version
        node {
            role = "control-plane"
        }
        node {
            role = "worker"
        }
    }
}