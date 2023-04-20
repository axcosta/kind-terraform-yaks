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
                yaml_path   = "apps/yaks/subscription.yaml"
                name        = "yaks-poc"
                namespace   = "operators"
                channel     = "alpha"
                operator    = {
                    name    = "yaks"
                    source  = {
                        name        = "operatorhubio-catalog"
                        namespace   = "olm"
                    }                    
                }
            }
        }
    }   
}