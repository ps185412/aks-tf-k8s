# --------------------------------------------------------------------------------
# Common
# --------------------------------------------------------------------------------
location                = "West Europe"
prefix                  = "myorg-project-tf" # Replace with your own Values

# --------------------------------------------------------------------------------
# service principal for tf and azure AD
# --------------------------------------------------------------------------------
# Replace with your group_id
# ad_group_name           = "myorg_project_group" # Replace with your own Values

# For terraform creating the cluster
# Replace this with your TF client APP name
# tf_client_app_name      = "terraform-k8s" # Replace with your own Values

# For Kubernetes using RBAC 
# Enterprise application

# ad_client_app_name      = "AKSAADClient" # Replace with your own Values

# For Kubernetes using RBAC
# Enterprise application
# ad_server_app_name      = "AKSAADServer" # Replace with your own Values

# --------------------------------------------------------------------------------
# azure storage
# --------------------------------------------------------------------------------
storage_account_name    = "tfk8svolumestorage"