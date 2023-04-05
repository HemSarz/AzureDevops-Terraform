resource "azuredevops_serviceendpoint_azurerm" "AzServEndPoint" {
  project_id                = azuredevops_project.adoproj.id
  service_endpoint_name     = "AZ Server Conn"
  azurerm_spn_tenantid      = var.tenant_id
  azurerm_subscription_id   = var.subscription_id
  azurerm_subscription_name = "payg"
}

resource "azuredevops_serviceendpoint_github" "Github_ServiceEndpoint_PAT" {
  project_id            = azuredevops_project.adoproj.id
  service_endpoint_name = "Github Service Conn"

  auth_personal {
    personal_access_token = var.AZDO_GITHUB_SERVICE_CONNECTION_PAT
  }
}