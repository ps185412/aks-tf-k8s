data "azurerm_container_registry" "acr" {
  resource_group_name = "${var.acr_resource_group_name}"
  name = "${var.acr_name}"
}

data "azuread_service_principal" "tf-service-principal" {
  display_name = "terraform-k8s"
}

data "azurerm_client_config" "cli" {}

resource "azurerm_role_assignment" "role" {
  scope                = "${data.azurerm_container_registry.acr.id}"
  role_definition_name = "acrpull"
  principal_id         = "${data.azuread_service_principal.tf-service-principal.object_id}" 
}

