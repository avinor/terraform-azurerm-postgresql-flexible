# PostgreSQL Flexible Server.

A general terraform module to create an Azure PostgreSQL Flexible Server on av private network.

## Requirements

## Usage

To create a simple PostgreSQL flexible server.

```terraform
module "simple" {
  source = "https://github.com/avinor/terraform-azurerm-postgresql-flexible"

  name                = "simple"
  resource_group_name = "simple-rg"
  location            = "norwayeast"
}
```
