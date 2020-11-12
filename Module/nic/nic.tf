resource "azurerm_network_interface" "nic" {
  name                = "${var.project}-myNIC"
  location            = "${var.location}"
  resource_group_name = "${var.rg_name}"

  ip_configuration {
    name                          = "${var.project}-myNicConfiguration"
    subnet_id                     = "${var.network}"
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = "${var.public_ip_address_id}"
  }

  tags = {
    environment = "${var.environment}"
  }
}

resource "azurerm_network_interface_security_group_association" "example" {
  network_interface_id      = azurerm_network_interface.nic.id
  network_security_group_id = "${var.nsg_id}"
}

output "network_interface_id" {
  value = "${azurerm_network_interface.nic.id}"
}
