terraform {
  backend "azurerm" {}
}
provider "azurerm" {
  version = ">=1.28.0"
}

# --------------------------------------------------------------------------------
# Configure AzureRM provider
# --------------------------------------------------------------------------------
data "azurerm_client_config" "azurerm_provider" {}

# --------------------------------------------------------------------------------
# Get terraform service principal
# --------------------------------------------------------------------------------
# data "azuread_service_principal" "tf_client_app" {
#    display_name = "${var.tf_client_app_name}"
# }

# --------------------------------------------------------------------------------
# Get K8s RBAC client app service principal
# --------------------------------------------------------------------------------
data "azuread_application" "ad_client_app" {
    name = "${var.ad_client_app_name}"
}

# --------------------------------------------------------------------------------
# Get K8s RBAC server app service principal
# --------------------------------------------------------------------------------
#data "azuread_application" "ad_server_app" {
#    name = "${var.ad_server_app_name}"
#}

# --------------------------------------------------------------------------------
# Get AAD Group
# --------------------------------------------------------------------------------
#data "azuread_group" "ad_group_name" {
#    name = "${var.ad_group_name}"
#}

# --------------------------------------------------------------------------------
# Module common-resource-group
#
# Create a resource group for all common infrastructure components
# --------------------------------------------------------------------------------
module "common_resource_group" {
    source = "./modules/resource-group"

    resource_group_name = "${var.prefix}-common-rg"
    location            = "${var.location}"
}


# --------------------------------------------------------------------------------
#  Module Azure Storage
# --------------------------------------------------------------------------------
module "aks-storage" {
    source = "./modules/aks-storage"

    storage_account_name                = "${var.storage_account_name}"
    storage_acount_resource_group_name  = "${module.common_resource_group.resource_group_name}"
    storage_acount_location             = "${var.location}"
}

# --------------------------------------------------------------------------------
#
# Azure key vault secret for  common infrastructure components (ClientSecret)
# --------------------------------------------------------------------------------
module "keyvault_common" {
    source = "./modules/secrets"

    keyvault_name                               = "${var.prefix}-common-vault"
    keyvault_resource_group_name                = "${module.common_resource_group.resource_group_name}"
    keyvault_location                           = "${var.location}"
    keyvault_access_tenant_id                   = "${data.azurerm_client_config.azurerm_provider.tenant_id}"
    keyvault_access_ad_group_id                 = "${data.azuread_group.ad_group_name.id}"
    
    keyvault_tf_client_app_object_id            = "${data.azuread_service_principal.tf_client_app.object_id}"
    keyvault_tf_client_app_application_id       = "${data.azuread_service_principal.tf_client_app.application_id}"
    keyvault_ad_client_app_application_id       = "${data.azuread_application.ad_client_app.application_id}"
    keyvault_ad_server_app_application_id       = "${data.azuread_application.ad_server_app.application_id}"
    keyvault_ad_server_app_application_secret   = ""
    
    keyvault_aks_storage_account_access_key     = "${module.aks-storage.primary_access_key}"
}
