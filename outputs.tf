output "sentinel_id" {
  value       = try(azurerm_sentinel_log_analytics_workspace_onboarding.main[0].id, null)
  description = "The ID of the Security Insights Sentinel Onboarding States."
}
output "iot_id" {
  value       = try(azurerm_sentinel_data_connector_iot.main[0].id, null)
  description = "The ID of the Iot Data Connector."
}
output "security_center_id" {
  value       = try(azurerm_sentinel_data_connector_azure_security_center.main[0].id, null)
  description = "The ID of the Azure Security Center Data Connector."
}
output "dtc_ad_id" {
  value       = try(azurerm_sentinel_data_connector_azure_active_directory.main[0].id, null)
  description = " The ID of the Azure Active Directory Data Connector."
}
output "dtc_threat_protection_id" {
  value       = try(azurerm_sentinel_data_connector_azure_advanced_threat_protection.main[0].id, null)
  description = "The ID of the Azure Advanced Threat Protection Data Connector."
}
output "dtc_ms_cloud_app_security_id" {
  value       = try(azurerm_sentinel_data_connector_microsoft_cloud_app_security.main[0].id, null)
  description = "The ID of the Microsoft Cloud App Security Data Connector."
}

output "existing_resource_group_id" {
  description = "The ID of the existing resource group"
  value       = data.azurerm_resource_group.existing.id
}

output "existing_resource_group_name" {
  description = "The name of the existing resource group"
  value       = data.azurerm_resource_group.existing.name
}

output "existing_workspace_id" {
  description = "The ID of the existing Log Analytics Workspace"
  value       = data.azurerm_log_analytics_workspace.existing.id
}

output "existing_workspace_name" {
  description = "The name of the existing Log Analytics Workspace"
  value       = data.azurerm_log_analytics_workspace.existing.name
}

output "sentinel_solution_id" {
  description = "The ID of the Microsoft Sentinel Solution"
  value       = azurerm_log_analytics_solution.sentinel.id
}
