output "id" {
  description = "Id of the postgresql flex server created."
  value       = azurerm_postgresql_flexible_server.server.id
}

output "fqdn" {
  description = "The FQDN of the PostgreSQL Flexible Server."
  value       = azurerm_postgresql_flexible_server.server.fqdn
}

output "administrator_login" {
  description = "Administrator login name"
  value       = azurerm_postgresql_flexible_server.server.administrator_login
  sensitive   = true
}

output "administrator_password" {
  description = "Administrator password"
  value       = azurerm_postgresql_flexible_server.server.administrator_password
  sensitive   = true
}