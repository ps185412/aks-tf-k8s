data "azurerm_client_config" "keyvault" {}

#!!!! This display_name should the same as defined in the pre-init.(There we created  )
data "azuread_service_principal" "tf-service-principal" {
  display_name = "terraform-k8s"
}

resource "azurerm_key_vault" "keyvault" {
  name                        = "${var.prefix}-vault"
  location                    = "${var.location}"
  resource_group_name         = "${var.resource_group_name}"
  enabled_for_disk_encryption = true
  tenant_id                   = "${data.azurerm_client_config.keyvault.tenant_id}"

  sku_name = "standard"

  access_policy {
    tenant_id = "${data.azurerm_client_config.keyvault.tenant_id}"
    object_id = "${data.azuread_service_principal.tf-service-principal.object_id}"

    key_permissions = []
    secret_permissions = ["get"]
    storage_permissions = []
  }

  access_policy {
    tenant_id = "${data.azurerm_client_config.keyvault.tenant_id}"
    object_id = "${var.azure_ad_group_id}"

    key_permissions = []
    secret_permissions = ["get","list","delete","set"]
    storage_permissions = []
  }

  network_acls {
    default_action = "Allow"
    bypass         = "AzureServices"
  }
}


resource "azurerm_key_vault_secret" "kubernetes_volume" {
  name = "aks-volume-storage"
  value = "{\"azurestorageaccountname\" : \"${var.aks_storage_account_name}\", \"azurestorageaccountkey\" : \"${var.aks_storage_account_access_key}\"}"
  key_vault_id = "${azurerm_key_vault.keyvault.id}"
}
