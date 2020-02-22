output "workspace_id" {
  value = "${azurerm_log_analytics_workspace.logging.workspace_id}"
}

output "workspace_secret_id" {
  value = "${azurerm_log_analytics_workspace.logging.primary_shared_key}"
}