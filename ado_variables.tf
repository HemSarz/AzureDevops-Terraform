resource "azuredevops_variable_group" "hawaVB" {
  project_id   = azuredevops_project.adoproj.id
  name         = "Terraform Sensitive Variables"
  description  = "This Variable Group should be linked to an Azure Key Vault"
  allow_access = true #Boolean that indicate if this variable group is shared by all pipelines of this project.

  key_vault {
    name                = azurerm_key_vault.kv.name
    service_endpoint_id = azuredevops_serviceendpoint_azurerm.AzServEndPoint.id
  }

  variable {
    name = "SASPass"
  }

  variable {
    name = "SPNPass"
  }

  variable {
    name = "VMAdminPass"
  }
}