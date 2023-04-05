#ResourceGroup

resource "azurerm_resource_group" "rg_name" {
  name     = var.rg_name
  location = var.location
}

# KeyVault
resource "azurerm_key_vault" "kv" {
  name                            = var.keyvault_name
  location                        = var.location
  resource_group_name             = azurerm_resource_group.rg_name.name
  tenant_id                       = var.tenant_id
  sku_name                        = "standard"
  enabled_for_deployment          = true
  enabled_for_disk_encryption     = true
  enabled_for_template_deployment = true
  purge_protection_enabled        = true
}

# Access Policy KV

resource "azurerm_key_vault_access_policy" "Current" {
  key_vault_id = azurerm_key_vault.kv.id
  tenant_id    = var.tenant_id
  object_id    = data.azurerm_client_config.current.object_id

  secret_permissions = [
    "Get",
    "List",
    "Set"
  ]

  storage_permissions = [
    "Get",
    "List",
    "Set"
  ]
}

#ManagedUser

resource "azurerm_user_assigned_identity" "tfazkvuser" {
  resource_group_name = azurerm_resource_group.rg_name.name
  location            = azurerm_resource_group.rg_name.location
  name                = "tfazkvuser"
}