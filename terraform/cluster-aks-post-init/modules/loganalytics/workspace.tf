# Create LogAnalyticsWorkspace
resource "azurerm_log_analytics_workspace" "logging" {
  name                = "${var.prefix}-log-workspace-${var.workspace_name}"
  location            = "${var.location}"
  resource_group_name = "${var.resource_group_name}"
  sku                 = "Standalone"
  retention_in_days   = 30
}
