subscription_id = ""
client_id = ""
client_secret = ""
tenant_id = ""
location = "westeurope"
resource_group_name = "automated7rg"
vm_count = 2

virtual_network {
    name = "app-vnet"
    address_space =  "10.0.0.0/16"
}

private_subnet {
    name = "app-private-subnet"
    address_prefix = "10.0.1.0/24"
}

gateway_subnet {
    name = "GatewaySubnet"
    address_prefix = "10.0.2.0/24"
}

public_ip {
    name = "app-public-ip"
    allocation_method = "Dynamic"
}

security_group {
    name = "app-security-group"
}

diag_storage = {
    name = "diag"
    account_tier = "Standard"
    account_replication_type = "LRS"
}

vm_nic {    
    nic_prefix = "app-nic"
    ip_configuration_name = "app-vm-nic-conf"
    ip_configuration_private_ip_address_allocation = "Dynamic"
} 

vm {
    vm_size = "Standard_DS1_v2"
    vm_prefix = "app-vm"

    delete_data_disks_on_termination = true
    delete_os_disk_on_termination = true

    storage_os_disk_caching = "ReadWrite"
    storage_os_disk_create_option = "FromImage"
    storage_os_disk_managed_disk_type = "Premium_LRS"

    storage_image_reference_publisher = "Canonical"
    storage_image_reference_offer     = "UbuntuServer"
    storage_image_reference_sku       = "18.04-LTS"
    storage_image_reference_version   = "latest"

    admin_username = "thso"
    admin_password = "Password1234!"
    admin_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDJul6LvumQH2CUbPHep99Gzhsq/i2BBfWQmFLp1n4BnScMvpJml5Mq2uQnfj/5xGqxCHG0gkil4PfJIstXg1waLEPVjnTuunXhhMOpnE3GMEXyZDWzAaWB8TfFkm+tBXSryLAztHDGcuxaRyuXrf0UHVTLNiwwmiDoAwdRpBVmAUQW4j+rX7JG5FPqi481iX7v4THO8WpL0zwhqeeYmj2NXhdjyK9pK9JkDq8BAjFQ+zFwRMIEhtkJ6kd5qN36zC02IknwGD2TcLDjBYSsiZGX9da6mjVT4zhBhI6BHLyn5hXQoqflD8+52z4lMef+iF2wNjZLI+A6PDRc80Za8JGL"
    disable_password_authentication = false
    boot_diagnostics = true
}

gateway = {
    name = "app-gateway"
    type = "Vpn"
    vpn_type ="RouteBased"
    active_active = false
    enable_bgp = false
    sku = "VpnGw1"

    ip_configuration_name = "vnetGatewayConfig"
    ip_configuration_private_ip_address_allocation = "Dynamic"

    vpn_client_configuration_address_space = "172.16.242.0/24"
    vpn_client_configuration_cert_name = "ODOOTHSO"
    vpn_client_configuration_public_cert_data = <<EOF
MIIC4TCCAcmgAwIBAgIQIi8xeUFc4b5LRkgSE04WAjANBgkqhkiG9w0BAQsFADAT MREwDwYDVQQDDAhPRE9PVEhTTzAeFw0xOTA0MDgwOTM5MzBaFw0yMDA0MDgwOTU5 MzBaMBMxETAPBgNVBAMMCE9ET09USFNPMIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8A MIIBCgKCAQEAucb8qoYT+SvS6i7ksUtPE2/BpbSUV50C0DJX9ij8/5VXIYj/K9cm AA+q5u9In+LtbCYVIp6gBECjswlI0BkglahfVmQ+/Fa311FyrCA39If2NXNcepyj fMUpUxSxEzpiY6uaTlhQtBRlu3moUmPyBFQHgqYd4WvMxNCl73hOJsFIEfp3KKTc LWa5DmRA/h2r0aY6QbzLcP+a1FTlhiFrXO3moTizgFD4O2dtBi6/ywWlbMKJaMbr mEuuZB5QS5hhFxYrf9iut+D+torHMrKy5x7CmQ3HKMGsk5zpcPYjhxFvHLvPUHIs LxUKnuuIH9PiwO/jCBoqhNKaBdhFdfXEdwIDAQABozEwLzAOBgNVHQ8BAf8EBAMC AgQwHQYDVR0OBBYEFHGxnO+AYua0mqQr364dwBp2m+ekMA0GCSqGSIb3DQEBCwUA A4IBAQBFYKg00+zqZ13FTQg3ebKEfKEXM1k6GJL9qzVckCr7jxH6biulcwEDrRkj cz8iSJWTwFPEt2wt/ljt/mntnr/xzmhhkzDZe+8Z/t05wkD+B89IJkgfB09LoyXh L5QStcRQaOJUVAVniSyHo5RsuASkoYhKzoh1xMRaaNx/N4dMY4t6odKrQA+aaQor DkFT1RersnLlCrb/rb5Z1UxzlHzubG4QYbZjHZSMhgi5ZCZYwqRPhIzTwE6ocGwV 9O4cAqX1gLgtypefkN62gLo8EoNeVMyrYNPxdQvgEjG8AN6wLE9MSqZCOd73sS9L k2A1qnZUkLS7CmHgnT+KJfTXszuV
EOF
}

file_storage = {
    name = "appfilestorage"
    account_tier = "Standard"
    account_replication_type = "LRS"
}

psql = {
    name = "psql"
    sku_name     = "GP_Gen5_2"
    sku_capacity = 2
    sku_tier     = "GeneralPurpose"
    sku_family   = "Gen5"   
    storage_profile_storage_mb = 5120
    storage_profile_backup_retention_days = 7
    administrator_login = "psqladminun"
    administrator_login_password = "Passw0rd"
    version = "9.6"
    ssl_enforcement = "Enabled"    
}