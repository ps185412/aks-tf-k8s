terraform {
  backend          "azurerm"        {}
}

provider "azurerm" {
  version = ">=1.28.0"
}


provider "kubernetes" {
  host                     = "${module.aks.admin_host}"
  client_certificate       = "${base64decode(module.aks.admin_client_certificate)}"
  client_key               = "${base64decode(module.aks.admin_client_key)}"
  cluster_ca_certificate   = "${base64decode(module.aks.admin_cluster_ca_certificate)}"
}

module "waf" {
  source = "./modules/waf"

  resource_group_name                   = "${var.environment}-${var.resource_group}"
  location                              = "${var.location}"
  ssl_certificate_pwd				          	= "${data.azurerm_key_vault_secret.passwd.value}"
  backend_address_pool_ip_addresses     = "${var.backend_address_pool_ip_addresses}"
  probe_status_code                     = "${var.cluster_specific_probe_status_code}"
}

module "aks" {
  source = "./modules/aks"

  ## Fetching from Vault Start
  client_id               = "${data.azurerm_key_vault_secret.tf_client_id.value}"
  client_secret           = "${data.azurerm_key_vault_secret.tf_client_secret.value}"
  ad_client_app_id        = "${data.azurerm_key_vault_secret.ad_client_app_id.value}"
  ad_server_app_id        = "${data.azurerm_key_vault_secret.ad_server_app_id.value}"
  ad_server_app_secret    = "${data.azurerm_key_vault_secret.ad_server_app_secret.value}"
  ## Fetching from Vault End

  enable_rbac             = "true"
  agent_count             = "${var.agent_count}"
  vm_size                 = "${var.vm_size}"
  k8s_version             = "${var.k8s_version}"
  os_disk_size_gb         = "${var.os_disk_size_gb}"
  prefix                  = "${var.environment}-tf-k8s"
  dns_prefix              = "${var.environment}-tf-k8s"
  cluster_name            = "${var.environment}-tf-k8s"
  vnet_subnet_id          = "${module.waf.kubesubnet_id}"
  resource_group_name     = "${module.waf.rg-name}"
  location                = "${module.waf.location}"
}

module "rbac" {
  source = "./modules/rbac"

  azure_ad_group_id = "${data.azurerm_key_vault_secret.ad_group_id.value}"
  clusterrole_binding_metadata = "cluster-admins"
}

# Enable if you are still on Helm 2.0 ( Not recommended )
/*
module "tiller" {
  source = "./modules/tiller"

  azurerm_resource_group_k8s_name     = "${module.waf.rg-name}"
  azurerm_kubernetes_cluster_k8s_name = "${module.aks.name}"
}
*/
module "helm" {
  source = "./modules/helm"
  azurerm_kubernetes_cluster_k8s_name = "${module.aks.name}"
  azurerm_resource_group_k8s_name = "${module.waf.rg-name}"
}

/*
module "dns-zone" {
  source = "./modules/dns-zone"
  
  dns_a_record_names  = "${var.dns_a_record_names}"
  dns_zone_name       = "${var.dns_zone_name}"
  dns_zone_rg_name    = "${var.dns_zone_rg_name}"
  ag_public_ip        = "${module.waf.ip-address}"
  location            = "${var.location}"
}
*/
/**
module "loganalytics" {
  source = "./modules/loganalytics"

  location            = "${var.location}"
  resource_group_name = "${module.waf.rg-name}"
  workspace_name      = "analytics"
  prefix              = "${module.aks.cluster_name}"
  key_vault_id        = "${module.cluster-secrets-vault.keyvault-id}"
}
*/
module "cluster-secrets" {
  source                          = "./modules/secrets"

  location                        = "${var.location}"
  resource_group_name             = "${module.waf.rg-name}"
  prefix                          = "${var.environment}"
  azure_ad_group_id               = "${data.azurerm_key_vault_secret.ad_group_id.value}"
  aks_storage_account_access_key  = "${data.azurerm_key_vault_secret.aks_storage_account_access_key.value}"
  aks_storage_account_name        = "${var.storage_account_name}"
}