variable "terraform_managed_by_label" {
    default = {
        "app.kubernetes.io/managed-by" = "terraform" 
    }
}
variable "kubernetes_resources" {
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
    default = {
        name        = "kind-lab-k8s-cluster"
        node_image  = "kindest/node:v1.24.0"
        api_version = "kind.x-k8s.io/v1alpha4"
    }
}
variable "apps" {
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
                name            = "yaks-poc"
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