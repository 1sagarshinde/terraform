resource "azurerm_public_ip" "publicip" {
  name                = "${var.project}-myPublicIP"
  location            = "${var.location}"
  resource_group_name = "${var.rg_name}"
  allocation_method   = "${var.allocation_method}"

  tags = {
    environment = "${var.environment}"
  }
}

output "publicip_name" {
  value = "${azurerm_public_ip.publicip.name}"
}
output "public_ip_id" {
  value = "${azurerm_public_ip.publicip.id}"
}
