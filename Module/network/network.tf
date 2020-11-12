resource "azurerm_virtual_network" "vnet" {
  name                = "${var.project}-resources"
  address_space       = "${var.address_space}"
  location            = "${var.location}"
  resource_group_name = "${var.rg_name}"

  tags = {
    environment = "${var.environment}"
  }
}
output "vnet_name" {
  value = "${azurerm_virtual_network.vnet.name}"
}

resource "azurerm_subnet" "subnet" {
  name                 = "${var.project}-mySubnet"
  resource_group_name  = "${var.rg_name}"
  virtual_network_name = "${azurerm_virtual_network.vnet.name}"
  address_prefixes     = "${var.address_prefixes}"
  service_endpoints    = ["Microsoft.Sql"]
}
#output "address_prefixes" {
#  value = "${azurerm_subnet.subnet.address_prefixes}"
#}
output "subnet_id" {
  value = "${azurerm_subnet.subnet.id}"
}

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

resource "azurerm_network_interface" "nic" {
  name                = "${var.project}-myNIC"
  location            = "${var.location}"
  resource_group_name = "${var.rg_name}"

  ip_configuration {
    name                          = "${var.project}-myNicConfiguration"
    subnet_id                     = "${azurerm_subnet.subnet.id}"
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = "${azurerm_public_ip.publicip.id}"
  }

  tags = {
    environment = "${var.environment}"
  }
}
#output "private_ip" {
#  value = "${azurerm_network_interface.nic.private_ip_address_allocation.name}"
#}

resource "azurerm_network_interface_security_group_association" "example" {
  network_interface_id      = azurerm_network_interface.nic.id
  network_security_group_id = "${var.nsg_id}"
}

output "network_interface_id" {
  value = "${azurerm_network_interface.nic.id}"
}
