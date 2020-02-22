# Creating Log Analytics workspace
resource "azurerm_log_analytics_workspace" "k8s" {
  name                = "${var.prefix}-log-workspace"
  location            = "${var.location}"
  resource_group_name = "${var.resource_group_name}"
  sku                 = "Standalone"
}

# Creating Log analytics solution for a workspace
resource "azurerm_log_analytics_solution" "k8s" {
  solution_name         = "ContainerInsights"
  location            = "${var.location}"
  resource_group_name = "${var.resource_group_name}"
  workspace_resource_id = "${azurerm_log_analytics_workspace.k8s.id}"
  workspace_name        = "${azurerm_log_analytics_workspace.k8s.name}"

  plan {
    publisher = "Microsoft"
    product   = "OMSGallery/ContainerInsights"
  }
}

