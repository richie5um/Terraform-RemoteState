resource "azurerm_storage_account" "sa-func-helloworld" {
  name                     = "funchelloworld${module.resource-group.rg-rnd.hex}"
  resource_group_name      = module.resource-group.rg-main.name
  location                 = module.resource-group.rg-main.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
}

data "azurerm_storage_account_sas" "sas-func-helloworld" {
  connection_string = azurerm_storage_account.sa-func-helloworld.primary_connection_string
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