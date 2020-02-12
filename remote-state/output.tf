output "resource_group" {
  value = "\"${azurerm_resource_group.rg-main.name}\""
}

output "storage_account_name" {
  value = "\"${azurerm_storage_account.sa-remote-state.name}\""
}

output "container_name" {
  value = "\"${azurerm_storage_container.sc-remote-state.name}\""
}

output "access_key" {
  value = "\"${azurerm_storage_account.sa-remote-state.primary_access_key}\""
}