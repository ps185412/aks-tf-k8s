# --------------------------------------------------------------------------------
# Azure storage account
# --------------------------------------------------------------------------------
resource "azurerm_storage_account" "aks_storage_account" {
  name                     = "${var.storage_account_name}"
  resource_group_name      = "${var.storage_acount_resource_group_name}"
  location                 = "${var.storage_acount_location}"
  account_tier             = "Standard"
  account_replication_type = "LRS"
}
