module "diagnostics" {

  source = "../../"

  name                = "diagnostics"
  resource_group_name = "diagnostics-rg"
  location            = "norwayeast"

  delegated_subnet_id = "/subscriptions/12345678-1234-1234-123456789012/resourceGroups/rg/providers/Microsoft.Network/virtualNetworks/vnet/subnets/subnet"
  private_dns_zone_id = "/subscriptions/12345678-1234-1234-123456789012/resourceGroups/rg/providers/Microsoft.Network/privateDnsZones/my.org.com"

  databases = [{ name = "mydb1" }]

  diagnostics = {
    log_analytics_workspace_id = "/subscriptions/XXXXXXXX-XXXX-XXXX-XXXX-XXXXXXXXXXXX/resourceGroups/XXXXXXXXXX/providers/Microsoft.OperationalInsights/workspaces/XXXXXXXXXX"
    logs                       = ["PostgreSQLLogs"]
    metrics                    = ["all"]
  }
}