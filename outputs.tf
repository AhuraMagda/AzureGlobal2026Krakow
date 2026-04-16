output "app_service_plan" {
  value = {
    name                = azurerm_service_plan.service_plan.name
    id                  = azurerm_service_plan.service_plan.id
    resource_group_name = "rg-user4"
  }
  description = "required output for other modules."
}