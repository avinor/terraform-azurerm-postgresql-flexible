module "simple" {

  source = "../../"

  name                = "simple"
  resource_group_name = "simple-rg"
  location            = "norwayeast"

  delegated_subnet_id = "/subscriptions/12345678-1234-1234-123456789012/resourceGroups/rg/providers/Microsoft.Network/virtualNetworks/vnet/subnets/subnet"
  private_dns_zone_id = "/subscriptions/12345678-1234-1234-123456789012/resourceGroups/rg/providers/Microsoft.Network/privateDnsZones/my.org.com"

  databases = [
    { name = "mydb1" },
    { name = "mydb2" },
  ]

  configurations = {
    "azure.extension" = "CUBE,CITEXT,BTREE_GIST"
  }

}