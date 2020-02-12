resource "azurerm_storage_account" "sa-func-helloworld" {
  name                     = "func${random_id.rg.hex}"
  resource_group_name      = azurerm_resource_group.rg-func-helloworld.name
  location                 = azurerm_resource_group.rg-func-helloworld.location
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