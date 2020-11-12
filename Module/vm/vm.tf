resource "azurerm_virtual_machine" "vm" {

  # CORE INFRASTRUCUTRE SETTIGNS
  count                            = 1
  name                             = "${var.project}-virtual-machine-${count.index + 1}"
  location                         = "${var.location}"
  resource_group_name              = "${var.rg_name}"
  network_interface_ids            = ["${var.nic}"]
  vm_size                          = "Standard_DS1_V2"
  delete_data_disks_on_termination = true

  # WHICH OS THE VM WILL HAVE
  storage_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "16.04-LTS"
    version   = "latest"
  }

  # MAIN STORAGE DISK
  storage_os_disk {
    name              = "machine-disk-${count.index + 1}"
    caching           = "ReadWrite"
    create_option     = "FromImage"
    managed_disk_type = "STANDARD_LRS"
  }


  # PROFILE OF THE VM - USER / PASSWORD
  os_profile {
    computer_name  = "test-vm"
    admin_username = "testadmin"
    admin_password = "Password123!!"
  }

  os_profile_linux_config {
    disable_password_authentication = false
  }

  # TAGS - KEY / VALUE PAIRS
  tags = {
    name                = "virtual-machine-${count.index + 1}"
    location            = "${var.location}"
    resource_group_name = "${var.rg_name}"
  }
}
