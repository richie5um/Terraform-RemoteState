resource "azurerm_storage_account" "sa-remote-state" {
  name                     = "remotestate${random_id.rg-rnd.hex}"
  resource_group_name      = azurerm_resource_group.rg-main.name
  location                 = azurerm_resource_group.rg-main.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
}

resource "azurerm_storage_container" "sc-remote-state" {
  name                  = "remotestate"
  resource_group_name   = azurerm_resource_group.rg-main.name
  storage_account_name  = azurerm_storage_account.sa-remote-state.name
  container_access_type = "private"
}

data "azurerm_storage_account_sas" "sas-remote-state" {
  connection_string = azurerm_storage_account.sa-remote-state.primary_connection_string
  https_only = false
  resource_types {
    service   = false
    container = false
    object    = true
  }
  services {
    blob  = true
    queue = false
    table = false
    file  = false
  }
  start  = "2018-03-21"
  expiry = "2028-03-21"
  permissions {
    read    = true
    write   = false
    delete  = false
    list    = false
    add     = false
    create  = false
    update  = false
    process = false
  }
}