terraform {
  required_providers {
    azuredevops = {
      source  = "microsoft/azuredevops"
      version = ">= 0.4.0"
    }
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">= 3.0.0"
    }
  }
}

provider "azurerm" {
  features {}
}

provider "azuredevops" {
  org_service_url       = var.AZDO_ORG_SERVICE_URL
  personal_access_token = var.AZDO_PERSONAL_ACCESS_TOKEN
}