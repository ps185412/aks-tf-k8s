output "primary_access_key" {
    value = "${azurerm_storage_account.aks_storage_account.primary_access_key}"
}