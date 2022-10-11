variable "name" {
  description = "Name of storage account. Unless var.exact_name is true any illegal characters (,-_ etc) will be truncated and 6 random characters will be appended to this value."
}

variable "resource_group_name" {
  description = "Name of resource group to deploy resources in."
}

variable "location" {
  description = "Azure location where resources should be deployed."
}

variable "postgresql_version" {
  description = "The version of PostgreSQL Flexible Server to use. Possible values are 11,12, 13 and 14"
  default     = "14"
}

variable "sku_name" {
  description = "The SKU Name for the PostgreSQL Flexible Server. The name of the SKU, follows the tier + name pattern (e.g. B_Standard_B1ms, GP_Standard_D2s_v3, MO_Standard_E4s_v3)."
  default     = "GP_Standard_D2s_v3"
}

variable "storage_mb" {
  description = "The max storage allowed for the PostgreSQL Flexible Server"
  default     = "32768"
}

variable "tags" {
  description = "Tags to apply to all resources created."
  type        = map(string)
  default     = {}
}