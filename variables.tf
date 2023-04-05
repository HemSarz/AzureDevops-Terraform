variable "client_secret" {
  type        = string
  default     = "1b7fb14c-e183-46f1-affc-5e1395a7dbdc"
  description = "description"
}

variable "tenant_id" {
  type        = string
  default     = "2b203c53-c460-43ff-88b3-cb8bb33c3fa9"
  description = "description"
}

variable "subscription_id" {
  type        = string
  default     = "60b8226d-3048-4a92-b759-c99f388752a1"
  description = "description"
}

variable "client_id" {
  type        = string
  default     = "ac31a660-2150-4dc6-942b-08c01c984401"
  description = "description"
}

variable "rg_name" {
  type        = string
  default     = "rg01hh"
  description = "description"
}

variable "stg_access_key" {
  type        = string
  default     = "56yfM9zD9TANHSBRh3oPgIKl0HsIjfaMb5GTmuC+zs5GlcAmho7v5WN6Uk7bF9ahwoPGLPkGdR1s+ASt/ux53g=="
  description = "description"
}

variable "VmAdminUser" {
  type        = string
  default     = "heha"
  description = "description"
}

variable "VMAdminPass" {
  type        = string
  default     = "Acer2012."
  description = "description"
}

variable "object_id_spn" {
  type        = string
  default     = "af3acd9c-9046-4786-9ad2-4ff46860f428"
  description = "description"
}

variable "environment" {
  type        = string
  default     = "dev"
  description = "description"
}

variable "location" {
  type        = string
  default     = "norwayeast"
  description = "description"
}

variable "storageAccount_name" {
  type        = string
  default     = "hhstg01"
  description = "description"
}

variable "container_name" {
  type        = string
  default     = "cont01"
  description = "description"
}

variable "keyvault_name" {
  type        = string
  default     = "kv01h"
  description = "description"
}

variable "AZDO_PERSONAL_ACCESS_TOKEN" {
  type        = string
  default     = "4xpary6gl7fkcp5pfa5ya7unybitquncwwkgl27wgaiz4qzbnpha"
  description = "description"
}

variable "AZDO_ORG_SERVICE_URL" {
  type        = string
  default     = "https://dev.azure.com/sarzali788"
  description = "description"
}

variable "AZDO_GITHUB_SERVICE_CONNECTION_PAT" {
  type        = string
  default     = "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"
  description = "description"
}


variable "name" {
  type        = string
  default     = ""
  description = "description"
}

variable "AzureAD_ApplicationName" {
  type        = string
  default     = "tfazSPN"
  description = "description"
}

variable "AzureAD_SPN_Password_Expiry" {
  type        = string
  default     = "2028-01-01T01:02:03Z"
  description = "The End Date which the Password is valid until, formatted as a RFC3339 date string (e.g. 2018-01-01T01:02:03Z)."
}