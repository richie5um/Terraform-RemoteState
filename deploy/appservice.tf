resource "azurerm_app_service_plan" "sp-func-helloworld" {
  name                = "func-helloworld"
  resource_group_name = module.resource-group.rg-main.name
  location            = module.resource-group.rg-main.location
  kind                = "FunctionApp"
  sku {
    tier = "Dynamic"
    size = "Y1"
  }
}
