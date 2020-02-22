variable "location" {
    description = "Location of the Cloud Provider(Azure)"
}

variable resource_group_name {
    description = "Resource group for Kubernetes Cluster"
}

variable "prefix" {
    description = "default prefix to use for resources."
}

variable "azure_ad_group_id" {
    description = "Service Principle to read Secrets from KeyVault"
}

variable "aks_storage_account_access_key" {
    description = "Storage Account AccessKey for Kubernetes Persistent Volume"
}

variable "aks_storage_account_name" {
    description = "Storage Account Name for Kubernetes Persistent Volume"
}
