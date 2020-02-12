provider "azurerm" { }

module "resource-group" {
  source = "../modules/resource-group"
}