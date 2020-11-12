resource "random_string" "random-name" {
  length  = 5
  upper   = false
  lower   = true
  number  = true
  special = false
}
resource "azurerm_storage_account" "storage" {
  name                     = "jdastorageaccount${random_string.random-name.result}"
  resource_group_name      = "${var.rg_name}"
  location                 = "${var.location}"
  account_tier             = "Standard"
  account_replication_type = "LRS"
}
