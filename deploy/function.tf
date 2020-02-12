resource "azurerm_storage_container" "sc-func-helloworld" {
  name                  = "func-helloworld-releases"
  resource_group_name   = module.resource-group.rg-main.name
  storage_account_name  = azurerm_storage_account.sa-func-helloworld.name
  container_access_type = "private"
}

resource "azurerm_storage_blob" "sb-func-helloworld" {
  name                   = "functionapp.zip"
  resource_group_name    = module.resource-group.rg-main.name
  storage_account_name   = azurerm_storage_account.sa-func-helloworld.name
  storage_container_name = azurerm_storage_container.sc-func-helloworld.name
  type                   = "block"
  source                 = "./func-HelloWorld/functionapp.zip"
}

resource "azurerm_function_app" "func-helloworld" {
  name                      = "func-helloworld"
  version                   = "~2"
  location                  = module.resource-group.rg-main.location
  resource_group_name       = module.resource-group.rg-main.name
  app_service_plan_id       = azurerm_app_service_plan.sp-func-helloworld.id
  storage_connection_string = azurerm_storage_account.sa-func-helloworld.primary_connection_string

  app_settings = {
    HASH            = "${filesha256("./func-HelloWorld/functionapp.zip")}"
    WEBSITE_USE_ZIP = "https://${azurerm_storage_account.sa-func-helloworld.name}.blob.core.windows.net/${azurerm_storage_container.sc-func-helloworld.name}/${azurerm_storage_blob.sb-func-helloworld.name}${data.azurerm_storage_account_sas.sas-func-helloworld.sas}"
  }
}

output "function_app" {
  value = "${azurerm_function_app.func-helloworld.default_hostname}"
}
