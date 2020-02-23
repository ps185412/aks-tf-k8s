# --------------------------------------------------------------------------------
# Create common azure key vault 
# --------------------------------------------------------------------------------
resource "azurerm_key_vault" "keyvault" {
  name                        = "${var.keyvault_name}"
  location                    = "${var.keyvault_location}"
  resource_group_name         = "${var.keyvault_resource_group_name}"
  enabled_for_disk_encryption = true
  tenant_id                   = "${var.keyvault_access_tenant_id}"

  sku_name = "standard"

  access_policy {
    tenant_id = "${var.keyvault_access_tenant_id}"
    object_id = "${var.keyvault_tf_client_app_object_id}"

    key_permissions = []
    secret_permissions = ["get"]
    storage_permissions = []
  }

  access_policy {
    tenant_id = "${var.keyvault_access_tenant_id}"
    object_id = "${var.keyvault_access_ad_group_id}"

    key_permissions = []
    secret_permissions = ["get","list","delete","set"]
    storage_permissions = []
  }

  network_acls {
    default_action = "Allow"
    bypass         = "AzureServices"
  }
}

# --------------------------------------------------------------------------------
# Create azure key vault secrets for service principals
# --------------------------------------------------------------------------------
# AKSAADClient
resource "azurerm_key_vault_secret" "ad_client_app_id" {
  name         = "adClientAppId"
  value        = "${var.keyvault_ad_client_app_application_id}"
  key_vault_id = "${azurerm_key_vault.keyvault.id}"
}

# AKSAADServer
resource "azurerm_key_vault_secret" "ad_server_app_id" {
  name         = "adServerAppId"
  value        = "${var.keyvault_ad_server_app_application_id}"
  key_vault_id = "${azurerm_key_vault.keyvault.id}"
}

resource "azurerm_key_vault_secret" "ad_server_app_secret" {
  name         = "adServerAppSecret"
  value        = "${var.keyvault_ad_server_app_application_secret}"
  key_vault_id = "${azurerm_key_vault.keyvault.id}"
}

# TF Service principal 
resource "azurerm_key_vault_secret" "tf_client_id" {
  name         = "tfClientId"
  value        = "${var.keyvault_tf_client_app_application_id}"
  key_vault_id = "${azurerm_key_vault.keyvault.id}"
}

resource "azurerm_key_vault_secret" "tf_client_secret" {
  name         = "tfClientSecret"
  value        = ""
  key_vault_id = "${azurerm_key_vault.keyvault.id}"
}

# AAD group for RBAC
resource "azurerm_key_vault_secret" "ad_group_id" {
  name         = "adGroupId"
  value        = "${var.keyvault_access_ad_group_id}"
  key_vault_id = "${azurerm_key_vault.keyvault.id}"
}

resource "azurerm_key_vault_secret" "aks_storage_account_access_key" {
  name          = "aksStorageAcountAccessKey"
  value         = "${var.keyvault_aks_storage_account_access_key}"
  key_vault_id  = "${azurerm_key_vault.keyvault.id}"
}