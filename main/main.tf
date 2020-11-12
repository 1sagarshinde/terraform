# Configure the Microsoft Azure Provider
provider "azurerm" {
  # The "feature" block is required for AzureRM provider 2.x.
  # If you're using version 1.x, the "features" block is not allowed.
  version = "~>2.0"
  features {}
}

terraform {
  backend "azurerm" {
    subscription_id      = "9b07432f-cf4c-4b84-878c-6e75b843255c"
    resource_group_name  = "jdarg"
    storage_account_name = "jdasagtstate09762"
    container_name       = "tstate"
    key                  = "terraform.tfstate"
  }
}

#module "rg" {
#  source      = "../Module/rg"
#  environment = "${var.environment}"
#  project     = "${var.project}"
#  location    = "${var.location}"
#}
module "network" {
  source        = "../Module/network"
  environment   = "${var.environment}"
  project       = "${var.project}"
  location      = "${var.location}"
  address_space = "${var.address_space}"
  #  rg_name           = "${module.rg.rg_name}"
  rg_name           = "${var.rg_name}"
  address_prefixes  = "${var.address_prefixes}"
  allocation_method = "${var.allocation_method}"
  nsg_id            = "${module.nsg.nsg_id}"
}
#module "subnet" {
#  source           = "../Module/subnet"
#  project          = "${var.project}"
#  rg_name          = "${module.rg.rg_name}"
#  vnet_name        = "${module.network.vnet_name}"
#  address_prefixes = "${var.address_prefixes}"
#}
#module "publicip" {
#  source            = "../Module/publicip"
#  project           = "${var.project}"
#  location          = "${var.location}"
#  environment       = "${var.environment}"
#  allocation_method = "${var.allocation_method}"
#  rg_name           = "${module.rg.rg_name}"
#}
module "nsg" {
  source      = "../Module/nsg"
  project     = "${var.project}"
  location    = "${var.location}"
  environment = "${var.environment}"
  #  rg_name     = "${module.rg.rg_name}"
  rg_name = "${var.rg_name}"
}
#module "nic" {
#  source               = "../Module/nsg"
#  project              = "${var.project}"
#  location             = "${var.location}"
#  environment          = "${var.environment}"
#  rg_name              = "${module.rg.rg_name}"
#  network              = "${module.subnet.network_id}"
#  public_ip_address_id = "${module.publicip.public_ip_id}"
#  nsg_id               = "${module.nsg.nsg_id}"
#}
module "vm" {
  source   = "../Module/vm"
  project  = "${var.project}"
  location = "${var.location}"
  #  rg_name  = "${module.rg.rg_name}"
  rg_name = "${var.rg_name}"
  nic     = "${module.network.network_interface_id}"
}
module "sqldb" {
  source   = "../Module/sqldb"
  project  = "${var.project}"
  location = "${var.location}"
  #  rg_name   = "${module.rg.rg_name}"
  rg_name   = "${var.rg_name}"
  subnet_id = "${module.network.subnet_id}"
  #end_ip_address      = "${var.end_ip_address}"
  #vnet_name           = "${module.network.vnet_name}"
  #address_prefixes_db = "${var.address_prefixes_db}"
}
module "storageaccount" {
  source   = "../Module/storageaccount"
  project  = "${var.project}"
  location = "${var.location}"
  #  rg_name  = "${module.rg.rg_name}"
  rg_name = "${var.rg_name}"
}
