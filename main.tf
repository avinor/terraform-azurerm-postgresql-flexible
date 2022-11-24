terraform {
  required_version = ">= 1.3"
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.32.0"
    }
    random = {
      source  = "hashicorp/random"
      version = "~> 3.4.3"
    }
  }
}

provider "azurerm" {
  features {}
}

resource "random_password" "uniq" {
  length  = 16
  special = true
  upper   = true
}

resource "azurerm_resource_group" "server" {
  name     = var.resource_group_name
  location = var.location
  tags     = var.tags
}

resource "azurerm_postgresql_flexible_server" "server" {
  name                = "${var.name}-psql"
  resource_group_name = azurerm_resource_group.server.name
  location            = azurerm_resource_group.server.location

  version                = var.postgresql_version
  sku_name               = var.sku_name
  storage_mb             = var.storage_mb
  delegated_subnet_id    = var.delegated_subnet_id
  private_dns_zone_id    = var.private_dns_zone_id
  backup_retention_days  = var.backup_retention_days
  administrator_login    = var.administrator
  administrator_password = random_password.uniq.result
  zone                   = var.zone
  tags                   = var.tags
}

resource "azurerm_postgresql_flexible_server_database" "database" {
  for_each = { for db in var.databases : db.name => db }

  name      = each.value.name
  server_id = azurerm_postgresql_flexible_server.server.id
  collation = each.value.collation
  charset   = each.value.charset
}

resource "azurerm_postgresql_flexible_server_configuration" "server" {
  for_each = var.configurations

  name      = each.key
  server_id = azurerm_postgresql_flexible_server.server.id
  value     = each.value
}

data "azurerm_monitor_diagnostic_categories" "server" {
  resource_id = azurerm_postgresql_flexible_server.server.id
}

resource "azurerm_monitor_diagnostic_setting" "server" {
  count = var.diagnostics != null ? 1 : 0

  name                       = "${var.name}-diag"
  target_resource_id         = azurerm_postgresql_flexible_server.server.id
  log_analytics_workspace_id = var.diagnostics.log_analytics_workspace_id

  dynamic "log" {
    for_each = data.azurerm_monitor_diagnostic_categories.server.log_category_types
    content {
      category = log.value
      enabled  = contains(var.diagnostics.logs, "all") || contains(var.diagnostics.logs, log.value)

      retention_policy {
        enabled = false
        days    = 0
      }
    }
  }

  dynamic "metric" {
    for_each = data.azurerm_monitor_diagnostic_categories.server.metrics
    content {
      category = metric.value
      enabled  = contains(var.diagnostics.metrics, "all") || contains(var.diagnostics.metrics, metric.value)

      retention_policy {
        enabled = false
        days    = 0
      }
    }
  }
}
