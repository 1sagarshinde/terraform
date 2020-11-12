resource "azurerm_resource_group" "rg" {
  name     = "${var.project}"
  location = "${var.location}"

  tags = {
    environment = "${var.environment}"
  }
}
output "rg_name" {
  value = "${azurerm_resource_group.rg.name}"
}
