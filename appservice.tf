resource "azurerm_app_service_plan" "sp-func-helloworld" {
  name                = "func-helloworld"
  resource_group_name = azurerm_resource_group.rg-func-helloworld.name
  location            = azurerm_resource_group.rg-func-helloworld.location
  kind                = "FunctionApp"
  sku {
    tier = "Dynamic"
    size = "Y1"
  }
}