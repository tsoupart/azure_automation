resource "azurerm_virtual_network" "app_vnet" {
    name                = "${var.virtual_network["name"]}"
    address_space       = ["${var.virtual_network["address_space"]}"]
    location            = "${var.location}"
    resource_group_name = "${azurerm_resource_group.app.name}"
}

resource "azurerm_subnet" "app_private_subnet" {
    name                 = "${var.private_subnet["name"]}"
    address_prefix       = "${var.private_subnet["address_prefix"]}"
    resource_group_name  = "${azurerm_resource_group.app.name}"
    virtual_network_name = "${azurerm_virtual_network.app_vnet.name}"
}

resource "azurerm_public_ip" "app_public_ip" {
    name                         = "${var.public_ip["name"]}"
    allocation_method            = "${var.public_ip["allocation_method"]}"
    location                     = "${var.location}"
    resource_group_name          = "${azurerm_resource_group.app.name}"
}

resource "azurerm_network_security_group" "app_security_group" {
    name                = "${var.security_group["name"]}"
    location            = "${var.location}"
    resource_group_name = "${azurerm_resource_group.app.name}"
    
    security_rule {
        name                       = "SSH"
        priority                   = 1001
        direction                  = "Inbound"
        access                     = "Allow"
        protocol                   = "Tcp"
        source_port_range          = "*"
        destination_port_range     = "22"
        source_address_prefix      = "*"
        destination_address_prefix = "*"
    }
}
