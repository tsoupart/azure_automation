resource "azurerm_network_interface" "app_vm_nic" {
    count                     = "${var.vm_count}"
    name                      = "${var.vm_nic["nic_prefix"]}${count.index}"
    location                  = "${var.location}"
    resource_group_name       = "${azurerm_resource_group.app.name}"
    network_security_group_id = "${azurerm_network_security_group.app_security_group.id}"

    ip_configuration {
        name                          = "${var.vm_nic["ip_configuration_name"]}"
        private_ip_address_allocation = "${var.vm_nic["ip_configuration_private_ip_address_allocation"]}"
        subnet_id                     = "${azurerm_subnet.app_private_subnet.id}"
    }
}

resource "azurerm_virtual_machine" "app_vm" {
    count                 = "${var.vm_count}"
    name                  = "${var.vm["vm_prefix"]}${count.index}"
    location              = "${var.location}"
    resource_group_name   = "${azurerm_resource_group.app.name}"
    network_interface_ids = ["${element(azurerm_network_interface.app_vm_nic.*.id, count.index)}"]
    vm_size               = "${var.vm["vm_size"]}"
    delete_data_disks_on_termination = "${var.vm["delete_data_disks_on_termination"]}"
    delete_os_disk_on_termination    = "${var.vm["delete_os_disk_on_termination"]}"

    storage_os_disk {
        name              =  "myOsDisk${count.index}"
        caching           = "${var.vm["storage_os_disk_caching"]}"
        create_option     = "${var.vm["storage_os_disk_create_option"]}"
        managed_disk_type = "${var.vm["storage_os_disk_managed_disk_type"]}"
    }

    storage_image_reference {
        publisher = "${var.vm["storage_image_reference_publisher"]}"
        offer     = "${var.vm["storage_image_reference_offer"]}"
        sku       = "${var.vm["storage_image_reference_sku"]}"
        version   = "${var.vm["storage_image_reference_version"]}"
    }

    os_profile {
        computer_name  = "app-vm${count.index}"
        admin_username = "${var.vm["admin_username"]}"
        admin_password = "${var.vm["admin_password"]}"
    }

    os_profile_linux_config {
        disable_password_authentication = "${var.vm["disable_password_authentication"]}"
        ssh_keys {
            path     = "/home/${var.vm["admin_username"]}/.ssh/authorized_keys"
            key_data = "${var.vm["admin_key"]}"
        }
    }

    boot_diagnostics {
        enabled = "${var.vm["boot_diagnostics"]}"
        storage_uri = "${azurerm_storage_account.app_diag_storage_account.primary_blob_endpoint}"
    }
}

# resource "azurerm_virtual_machine_extension" "app_vm1_AADLoginForLinux" {
#     name                              = "AADLoginForLinux"
#     location                          = "${azurerm_virtual_machine.app_vm1.location}"
#     resource_group_name               = "${azurerm_virtual_machine.app_vm1.resource_group_name}"
#     virtual_machine_name              = "${azurerm_virtual_machine.app_vm1.name}"
#     publisher                         = "Microsoft.Azure.ActiveDirectory.LinuxSSH"
#     type                              = "AADLoginForLinux"
#     type_handler_version              = "1.0"
#     auto_upgrade_minor_version        = true
# }


output "VM_IP" {
  value = "${azurerm_network_interface.app_vm_nic.*.private_ip_address}"
}
