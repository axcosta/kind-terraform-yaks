terraform {
  required_providers {
    kind        = {
      source  = "tehcyx/kind"
      version = "0.0.13"
    }    
    kubectl     = {
      source  = "gavinbunney/kubectl"
      version = "1.14.0"
    }
    time        = {
      source  = "hashicorp/time"
      version = "0.9.1"
    }
    # kubernetes  = {
    #   source  = "hashicorp/kubernetes"
    #   version = "2.20.0"
    # }
  }
}

provider "kind" {}

provider "kubectl" {
  # config_path       = "~/.kube/config"
  load_config_file        = false
  host                    = "${kind_cluster.lab_k8s_cluster.endpoint}"
  cluster_ca_certificate  = "${kind_cluster.lab_k8s_cluster.cluster_ca_certificate}"
  client_certificate      = "${kind_cluster.lab_k8s_cluster.client_certificate}"
  client_key              = "${kind_cluster.lab_k8s_cluster.client_key}"
}

provider "time" {}

# provider "kubernetes" {
#   # config_path       = "~/.kube/config"  
#   host                    = "${kind_cluster.lab_k8s_cluster.endpoint}"
#   cluster_ca_certificate  = "${kind_cluster.lab_k8s_cluster.cluster_ca_certificate}"
#   client_certificate      = "${kind_cluster.lab_k8s_cluster.client_certificate}"
#   client_key              = "${kind_cluster.lab_k8s_cluster.client_key}"
# }