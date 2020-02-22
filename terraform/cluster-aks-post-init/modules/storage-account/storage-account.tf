resource "azurerm_resource_group" "storage_rg" {
  name     = "${var.storage_rg_name}"
  location = "${var.storage_rg_location}"
}

resource "azurerm_storage_account" "storage_acc" {
  name                     = "${var.storage_acc_name}"
  resource_group_name      = "${azurerm_resource_group.storage_rg.name}"
  location                 = "${azurerm_resource_group.storage_rg.location}"
  account_tier             = "Standard"
  account_replication_type = "LRS"
}

resource "azurerm_storage_container" "storage_cnt" {
  name                  = "${var.storage_cnt_name}"
  resource_group_name   = "${azurerm_resource_group.storage_rg.name}"
  storage_account_name  = "${azurerm_storage_account.storage_acc.name}"
  container_access_type = "${var.storage_cnt_type}"
}

resource "azurerm_storage_blob" "storage_blob" {
  name = "${var.storage_blob_name}"

  resource_group_name    = "${azurerm_resource_group.storage_rg.name}"
  storage_account_name   = "${azurerm_storage_account.storage_acc.name}"
  storage_container_name = "${azurerm_storage_container.storage_cnt.name}"

  type = "page"
  size = 5120
}
