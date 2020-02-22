#---------I M P O R T A N T ----------------------------
# The names are the secret values coming from the common vault. This is as per your own 
# convention hence place add your own value.
#-------------------------------------------------------
data "azurerm_key_vault" "from_common_vault" {
  #name                = "prefix-common-vault"
  #resource_group_name = "prefix-common-rg"
}

data "azurerm_key_vault_secret" "tf_arm_access_key" {
  #name      = "<tfArmAccessKey>"
  key_vault_id = "${data.azurerm_key_vault.from_common_vault.id}"
}

# Fetch Client Id from azure vault
data "azurerm_key_vault_secret" "tf_client_id" {
  #name      = "<tfClientId>"
  key_vault_id = "${data.azurerm_key_vault.from_common_vault.id}"
}

# Fetch Client Secret from azure vault
data "azurerm_key_vault_secret" "tf_client_secret" {
  #name      = "<tfClientSecret>"
  key_vault_id = "${data.azurerm_key_vault.from_common_vault.id}"
}

# Fetch Azure Active Directory Client App Id
data "azurerm_key_vault_secret" "ad_client_app_id" {
  #name      = "<adClientAppId>"
  key_vault_id = "${data.azurerm_key_vault.from_common_vault.id}"
}

# Fetch Azure Active Directory Server App Id
data "azurerm_key_vault_secret" "ad_server_app_id" {
  #name      = "<adServerAppId>"
  key_vault_id = "${data.azurerm_key_vault.from_common_vault.id}"
}

# Fetch Azure Active Directory Server App Secret
data "azurerm_key_vault_secret" "ad_server_app_secret" {
  #name      = "<adServerAppSecret>"
  key_vault_id = "${data.azurerm_key_vault.from_common_vault.id}"
}

# Fetch Azure Active Directory group Id
data "azurerm_key_vault_secret" "ad_group_id" {
  #name      = "<adGroupId>"
  key_vault_id = "${data.azurerm_key_vault.from_common_vault.id}"
}