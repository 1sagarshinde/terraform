resource "azurerm_subnet" "subnet" {
  name                 = "${var.project}-mySubnet"
  resource_group_name  = "${var.rg_name}"
  virtual_network_name = "${var.vnet_name}"
  address_prefixes     = "${var.address_prefixes}"
}
#output "address_prefixes" {
#  value = "${azurerm_subnet.subnet.address_prefixes}"
#}
output "network_id" {
  value = "${azurerm_subnet.subnet.id}"
}
