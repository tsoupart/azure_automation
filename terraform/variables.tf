provider "azurerm" {
  subscription_id = "${var.subscription_id}"
  client_id = "${var.client_id}"
  client_secret = "${var.client_secret}"
  tenant_id = "${var.tenant_id}"
}
variable "subscription_id" {
  type = "string"
}
variable "client_id" {
  type = "string"
}
variable "client_secret" {
  type = "string"
}
variable "tenant_id" {
  type = "string"
}
variable "location" {
  type = "string"
}
variable "resource_group_name" {
  type = "string"
}
variable "virtual_network" {
  type = "map"
}
variable "private_subnet" {
  type = "map"
}
variable "gateway_subnet" {
  type = "map"
}
variable "public_ip" {
  type = "map"
}
variable "security_group" {
  type = "map"
}
variable "diag_storage" {
  type = "map"
}
variable "vm_count" {
  type = "string"
}

variable "vm" {
  type = "map"
}
variable "vm_nic" {
  type = "map"
}
variable "gateway" {
  type = "map"
}
variable "file_storage" {
  type = "map"
}
variable "psql" {
  type = "map"
}