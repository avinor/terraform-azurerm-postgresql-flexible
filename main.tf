terraform {
  required_version = ">= 1.3"
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.26.0"
    }
    #    random = {
    #      source  = "hashicorp/random"
    #      version = "~> 3.4.3"
    #    }
  }
}

provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "server" {
  name     = var.resource_group_name
  location = var.location
}

resource "azurerm_postgresql_flexible_server" "server" {
  name                = var.name
  resource_group_name = azurerm_resource_group.server.name
  location            = azurerm_resource_group.server.location

  version    = var.postgresql_version
  sku_name   = var.sku_name
  storage_mb = var.storage_mb

  tags = var.tags
}

