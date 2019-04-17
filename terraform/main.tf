resource "azurerm_resource_group" "app" {
    name     = "${var.resource_group_name}"
    location = "${var.location}"
}

resource "random_id" "randomId" {
    keepers = {
        # Generate a new ID only when a new resource group is defined
        resource_group = "${azurerm_resource_group.app.name}"
    }
    
    byte_length = 8
}