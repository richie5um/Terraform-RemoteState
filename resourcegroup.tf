resource "azurerm_resource_group" "rg-func-helloworld" {
  name     = "func-helloworld"
  location = "westeurope"
}

provider "random" { }

resource "random_id" "rg" {
  keepers = {
    # Generate a new id each time we switch to a new Azure Resource Group
    rg_id = "${azurerm_resource_group.rg-func-helloworld.name}"
  }

  byte_length = 8
}
