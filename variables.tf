variable "terraform_managed_by_label" {
    description = "Content of label to be put throughout all resources created in cluster"
    default = {
        "app.kubernetes.io/managed-by" = "terraform" 
    }
}
variable "kubernetes_resources" {
    description = "Type of resources created in cluster that will be labeled"
    default = {
        subscription = {
            api_version = "operators.coreos.com/v1alpha1"
            kind        = "Subscription"
        }
        instance    = {
            api_version = "yaks.citrusframework.org/v1alpha1"
            kind        = "Instance"
        }
    }
}
variable "cluster" {
    description = "Information to configure the K8s Cluster"
    default = {
        name        = "kind-lab-k8s-cluster"
        node_image  = "kindest/node:v1.24.0"
        api_version = "kind.x-k8s.io/v1alpha4"
    }
}
variable "apps" {
    description = "Information to configure applications in K8s Cluster"
    default = {
        olm     = {
            yamls = {
                crds    = "https://raw.githubusercontent.com/operator-framework/operator-lifecycle-manager/master/deploy/upstream/quickstart/crds.yaml"
                olm     = "https://raw.githubusercontent.com/operator-framework/operator-lifecycle-manager/master/deploy/upstream/quickstart/olm.yaml"
            }            
        }
        yaks    = {
            subscription = {
                yaml_path       = "apps/yaks/subscription.yaml"
                name            = "yaks-lab"
                namespace       = "operators"
                channel         = "alpha"
                operator        = {
                    name    = "yaks"
                    source  = {
                        name        = "operatorhubio-catalog"
                        namespace   = "olm"
                    }                    
                }
                time_to_wait    = "90s"
            }
            instance    = {
                yaml_path   = "apps/yaks/instance.yaml"
                name        = "yaks"
                namespace   = "operators"
                operator    = {
                    global      = false
                    namespace   = "operators"
                }
            }
        }
    }   
}