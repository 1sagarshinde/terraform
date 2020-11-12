variable "environment" {
  default     = "dev"
  description = "Environment"
}
variable "project" {
  default = "jda"
}
variable "location" {
  default     = "East US"
  description = "Region of resources"
}

variable "rg_name" {
  default     = "jdarg"
  description = " resources name"
}
# network variable

variable "address_space" {
  default     = ["10.0.0.0/16"]
  description = "network address space"
}

# subnet variable

variable "address_prefixes" {
  default     = ["10.0.0.0/24"]
  description = "network subnet"
}
variable "address_prefixes_db" {
  default     = ["11.0.1.0/24"]
  description = "network subnet"
}


# Public IP variable

variable "allocation_method" {
  default     = "Dynamic"
  description = "Public ip Dynamic or Static"
}

# sql db variable

variable "start_ip_address" {
  default = "[11.0.1.5/24]"
}
variable "end_ip_address" {
  default = "[11.0.1.5/24]"
}
