variable "keyvault_name" {
    description = "Name of the Key Vault"
}

variable "keyvault_resource_group_name" {
    description = "Resource Group Name"
}

variable "keyvault_location" {
    description = "Azure Location"
}


variable "keyvault_access_tenant_id" {
    description = "Tenant ID"
}


variable "keyvault_access_ad_group_id" {
    description = "ID of a Azure Active Directory Group"
}


variable "keyvault_tf_client_app_object_id" {
    description = "Object ID of the client Service Principle"
}

variable "keyvault_tf_client_app_application_id" {
    description = "Id for the Terraform Application linked to a Service Principle"
}

variable "keyvault_ad_client_app_application_id" {
    description = "Id for the Server Application linked to a Service Principle"
}

variable "keyvault_ad_server_app_application_id" {
    description = "Id for the Server Application linked to a Service Principle"
}

variable "keyvault_ad_server_app_application_secret" {
    description = "Secret for the Server Application linked to a Service Principle"
}

variable "keyvault_aks_storage_account_access_key" {
    description = "Primary Access Key for the Storage Account"
}