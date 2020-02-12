resource "azurerm_resource_group" "rg-main" {
  name     = "func-helloworld"
  location = "westeurope"
}

provider "random" { }

resource "random_id" "rg-rnd" {
  keepers = {
    # Generate a new id each time we switch to a new Azure Resource Group
    rg_id = "${azurerm_resource_group.rg-main.name}"
  }

  byte_length = 4
}
