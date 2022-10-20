# PostgreSQL Flexible Server.

A general terraform module to create an Azure PostgreSQL Flexible Server on av private network.

## Requirements

This module need already existing subnet delegated for postgresql and a private dns zone ending
with `.postgres.database.azure.com`.

## Usage

To create a simple PostgreSQL flexible server.

```terraform
module "simple" {
  source = "https://github.com/avinor/terraform-azurerm-postgresql-flexible"

  name                = "simple-postgres"
  resource_group_name = "simple-rg"
  location            = "norwayeast"

  delegated_subnet_id = "/subscriptions/11111111-1111-1111-1111-111111111111/resourceGroups/rg/providers/Microsoft.Network/virtualNetworks/vnet/subnets/subnet"
  private_dns_zone_id = "/subscriptions/11111111-1111-1111-1111-111111111111/resourceGroups/rg/providers/Microsoft.Network/privateDnsZones/my.org.com"

  databases = [
    { name = "mydb1" },
    { name = "mydb2" },
  ]
}
```

## Documentation

- [Azurerm provider](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/postgresql_flexible_server)
- [PostgreSQL Flexible Server docs](https://learn.microsoft.com/en-us/azure/postgresql/flexible-server/)