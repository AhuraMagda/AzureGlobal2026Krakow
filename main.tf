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