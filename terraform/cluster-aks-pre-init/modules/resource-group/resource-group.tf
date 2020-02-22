# --------------------------------------------------------------------------------
# ResourceGroup for common infrastructure components
# --------------------------------------------------------------------------------
resource "azurerm_resource_group" "common" {
    name     = "${var.resource_group_name}"
    location = "${var.location}"
}