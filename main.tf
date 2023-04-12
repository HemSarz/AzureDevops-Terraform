############ Azure ############

############ ResourceGroup ############

resource "azurerm_resource_group" "rg_name" {
  name     = var.rg_name
  location = var.location
}

############ Storage Account ############

resource "azurerm_storage_account" "stg" {
  name                     = var.storageAccount_name
  resource_group_name      = azurerm_resource_group.rg_name.name
  location                 = azurerm_resource_group.rg_name.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
}

#### Storage Container #####

resource "azurerm_storage_container" "cont" {
  name                  = var.cont_name
  storage_account_name  = azurerm_storage_account.stg.name
  container_access_type = "private"
}

output "stg_SASPass" {
  value     = data.azurerm_storage_account.stg.primary_access_key
  sensitive = true
}

############ KeyVault ############

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

############ Access Policy KV ############

resource "azurerm_key_vault_access_policy" "Current" {
  key_vault_id = azurerm_key_vault.kv.id
  object_id    = data.azurerm_client_config.current.object_id
  tenant_id    = data.azurerm_client_config.current.tenant_id

  secret_permissions  = ["Get", "List", "Set"]
  storage_permissions = ["Get", "List", "Set"]
}

############ Azure Service Endpoint ############

resource "azuredevops_serviceendpoint_azurerm" "AzServEndPoint" {
  project_id                = azuredevops_project.tfaz.id
  service_endpoint_name     = "AZ Server Conn"
  azurerm_spn_tenantid      = data.azurerm_client_config.current.tenant_id
  azurerm_subscription_id   = data.azurerm_client_config.current.subscription_id
  azurerm_subscription_name = var.sub_name

  credentials {
    serviceprincipalid  = azuread_service_principal.tfazsp.application_id
    serviceprincipalkey = azuread_service_principal_password.tfazsp.value
  }
}

############ SPN ############

resource "azuread_application" "tfazsp" {
  display_name = "tfazhh"
  owners       = [data.azuread_client_config.current.object_id]
}

resource "azuread_service_principal" "tfazsp" {
  application_id = azuread_application.tfazsp.application_id
  owners         = [data.azuread_client_config.current.object_id]
}

resource "azuread_service_principal_password" "tfazsp" {
  service_principal_id = azuread_service_principal.tfazsp.id
}

resource "azurerm_role_assignment" "main" {
  principal_id         = azuread_service_principal.tfazsp.id
  scope                = azurerm_key_vault.kv.id
  role_definition_name = "Contributor"
}

output "appid_tfazsp" {
  value     = data.azurerm_client_config.current.client_id
  sensitive = true
}

output "pass_tfazsp" {
  value     = azuread_service_principal_password.tfazsp.value
  sensitive = true
}

################# AZURE DEVOPS ################# 

############ Azure DevOps Project ############

resource "azuredevops_project" "tfaz" {
  name               = var.AdoProName
  description        = "AzureTerraformProject"
  visibility         = "private"
  version_control    = "Git"
  work_item_template = "Agile"

  features = {
    boards       = "enabled"
    repositories = "enabled"
    pipelines    = "enabled"
    testplans    = "enabled"
    artifacts    = "enabled"
  }
}

############ Azure DevOps REPO ############

resource "azuredevops_git_repository" "tfaz_repo" {
  project_id = azuredevops_project.tfaz.id
  name       = "TfazRepo"
  initialization {
    init_type = "Clean"
  }
}

############ Azure DevOps Pipeline ############

resource "azuredevops_build_definition" "DeployPipeline" {
  project_id      = azuredevops_project.tfaz.id
  name            = "tfaz_pipe"
  agent_pool_name = "Hosted Ubuntu 1604"

  ci_trigger {
    use_yaml = true
  }

  variable_groups = [

    azuredevops_variable_group.hawaVB.id

  ]

  repository {
    repo_type   = "TfsGit"
    repo_id     = azuredevops_project.tfaz.id
    branch_name = azuredevops_git_repository.tfaz_repo.default_branch
    yml_path    = "./BuildDefinitions/Example.yml"
  }
}