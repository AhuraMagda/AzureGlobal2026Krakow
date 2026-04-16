terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">=4.1.0"
    }
  }
}
provider "azurerm" {
  features {}
}

terraform {
  backend "azurerm" {
    resource_group_name  = "rg-user4"
    storage_account_name = "stglobalazureuser4"
    container_name       = "tfstate"
    key                  = "terraform.tfstate"
  }
}

module "keyvault" {
  source = "git::https://github.com/pchylak/global_azure_2026_ccoe.git?ref=keyvault/v1.0.0"
  keyvault_name = "gaazuser42026xyz"
  network_acls = {
    default_action             = "Deny"
    bypass                     = "AzureServices"
  }
  resource_group = {
    location = "North Europe"
    name     = "rg-user4"
  }
}

module "service_plan" {
  source = "git::https://github.com/pchylak/global_azure_2026_ccoe.git?ref=service_plan/v2.0.0"
  app_service_plan_name = "agspuser4"
  resource_group = {
    location = "North Europe"
    name     = "rg-user4"
  }
  sku_name = "B1"
  tags = {
    Environment = "dev"
  }
}

module "app_service" {
  source = "git::https://github.com/pchylak/global_azure_2026_ccoe.git?ref=app_service/v1.0.0"
  app_service_name = "agappserviceuser4"
  app_service_plan_id = module.service_plan.app_service_plan.id
  app_settings = {}
  identity_client_id = "8b23a4d8-7e9d-4973-8fb6-6275f20e7dca"
  identity_id = "8b23a4d8-7e9d-4973-8fb6-6275f20e7dca"
  resource_group = {
    location = "North Europe"
    name     = "rg-user4"
  }
}