data "azurerm_client_config" "current" {}
data "azuread_client_config" "current" {}

data "azurerm_storage_account" "stg" {
  name                = azurerm_storage_account.stg.name
  resource_group_name = azurerm_resource_group.rg_name.name
}

data "azuredevops_project" "tfaz" {
  name = var.AdoProName

  depends_on = [azuredevops_project.tfaz]
}