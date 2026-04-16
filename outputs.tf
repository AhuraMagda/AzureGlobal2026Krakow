output "app_service_plan" {
  value = {
    name                = module.service_plan.name
    id                  = module.service_plan.id
    resource_group_name = module.service_plan.resource_group_name
  }
  description = "required output for other modules."
}