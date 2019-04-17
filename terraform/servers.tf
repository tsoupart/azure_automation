
resource "azurerm_storage_account" "app_diag_storage_account" {
    name                        = "${random_id.randomId.hex}${var.diag_storage["name"]}"
    resource_group_name         = "${azurerm_resource_group.app.name}"
    location                    = "${var.location}"
    account_tier                = "${var.diag_storage["account_tier"]}"
    account_replication_type    = "${var.diag_storage["account_replication_type"]}"
}


resource "azurerm_storage_account" "app_file_storage" {
    name                        = "${var.file_storage["name"]}"
    resource_group_name         = "${azurerm_resource_group.app.name}"
    location                    = "${var.location}"
    account_tier                = "${var.file_storage["account_tier"]}"
    account_replication_type    = "${var.file_storage["account_replication_type"]}"
}

resource "azurerm_postgresql_server" "app_psql_server" {
  name                = "${random_id.randomId.hex}${var.psql["name"]}"
  location            = "${var.location}"
  resource_group_name = "${azurerm_resource_group.app.name}"

  sku {
    name     = "${var.psql["sku_name"]}"
    capacity = "${var.psql["sku_capacity"]}"
    tier     = "${var.psql["sku_tier"]}"
    family   = "${var.psql["sku_family"]}"
  }

  storage_profile {
    storage_mb            = "${var.psql["storage_profile_storage_mb"]}"
    backup_retention_days = "${var.psql["storage_profile_backup_retention_days"]}"
    geo_redundant_backup  = "Disabled"
  }

  administrator_login          = "${var.psql["administrator_login"]}"
  administrator_login_password = "${var.psql["administrator_login_password"]}"
  version                      = "${var.psql["version"]}"
  ssl_enforcement              = "${var.psql["ssl_enforcement"]}"
}