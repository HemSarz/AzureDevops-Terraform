resource "azuredevops_variable_group" "hawaVB" {
  project_id   = azuredevops_project.tfaz.id
  name         = "hawaVB"
  description  = "This Variable Group should be linked to an Azure Key Vault"
  allow_access = true

  variable {
    name      = "SPNPass"
    value     = azuread_service_principal_password.tfazsp.value
    is_secret = true
  }

  variable {
    name      = "SASPass"
    value     = azurerm_storage_account.stg.primary_access_key
    is_secret = true
  }

  variable {
    name      = "VMAdminPass"
    value     = var.VMAdminPass
    is_secret = true
  }
}