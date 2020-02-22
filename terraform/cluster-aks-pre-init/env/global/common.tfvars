# --------------------------------------------------------------------------------
# Common
# --------------------------------------------------------------------------------
location                = "West Europe"
prefix                  = "myorg-project-tf"

# --------------------------------------------------------------------------------
# service principal for tf and azure AD
# --------------------------------------------------------------------------------
ad_group_name           = "myorg_project_group"

# For terraform creating the cluster
tf_client_app_name      = "terraform-k8s"

# For Kubernetes using RBAC 
# Enterprise application
ad_client_app_name      = "AKSAADClient"

# For Kubernetes using RBAC
# Enterprise application
ad_server_app_name      = "AKSAADServer"

# --------------------------------------------------------------------------------
# azure storage
# --------------------------------------------------------------------------------
storage_account_name    = "tfk8svolumestorage"