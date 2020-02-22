# --------------------------------------------------------------------------------
# Common
# --------------------------------------------------------------------------------
variable "location" {
    description = "Location"
}

variable "prefix" {
    description = "Prefix for common resources"
}

# --------------------------------------------------------------------------------
# User, Groups, ServicePrincipal
# --------------------------------------------------------------------------------
variable "ad_group_name" {
    description = "Active Directory Group"
}

# Terraform client application (service principal) to create K8s cluster
variable "tf_client_app_name" {
    description = "Name of the terraform client application"
}

# Active Directory application (service principal) to set RBAC for K8s cluster
variable "ad_client_app_name" {
    description = "Name of the Server Active Directory application"
}

variable "ad_server_app_name" {
    description = "Name of the Client Active Directory application"
}

# --------------------------------------------------------------------------------
# Azure Storage Account
# --------------------------------------------------------------------------------
variable "storage_account_name" {
    description = "Name of the Kubernetes Storage Account"
}
