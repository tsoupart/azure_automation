

resource "azurerm_subnet" "app_gateway_subnet" {
  name                 = "${var.gateway_subnet["name"]}"
  address_prefix       = "${var.gateway_subnet["address_prefix"]}"
  resource_group_name  = "${azurerm_resource_group.app.name}"
  virtual_network_name = "${azurerm_virtual_network.app_vnet.name}"
}

resource "azurerm_virtual_network_gateway" "app_gateway" {
    name                    = "${var.gateway["name"]}"
    location                = "${var.location}"
    resource_group_name     = "${azurerm_resource_group.app.name}"

    type            = "${var.gateway["type"]}"
    vpn_type        = "${var.gateway["vpn_type"]}"
    active_active   = "${var.gateway["active_active"]}"
    enable_bgp      = "${var.gateway["enable_bgp"]}"
    sku             = "${var.gateway["sku"]}"

    ip_configuration {
        name                            = "${var.gateway["ip_configuration_name"]}"
        public_ip_address_id            = "${azurerm_public_ip.app_public_ip.id}"
        private_ip_address_allocation   = "${var.gateway["ip_configuration_private_ip_address_allocation"]}"
        subnet_id                       = "${azurerm_subnet.app_gateway_subnet.id}"

    }

    vpn_client_configuration {
        vpn_client_protocols = ["IkeV2", "OpenVPN"]
        address_space        = ["${var.gateway["vpn_client_configuration_address_space"]}"]
        root_certificate {
            name                = "${var.gateway["vpn_client_configuration_cert_name"]}"
            public_cert_data    = "${var.gateway["vpn_client_configuration_public_cert_data"]}"
        }
    }
}
