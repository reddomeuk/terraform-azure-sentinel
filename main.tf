terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.89.0"
    }
  }

  required_version = ">= 1.0.0"

  cloud {
    organization = "reddome_academy"
    workspaces {
      name = "terraform-azure-sentinel"
    }
  }
}

provider "azurerm" {
  features {
    resource_group {
      prevent_deletion_if_contains_resources = false
    }
  }
  skip_provider_registration = true
}

# Use data sources to reference existing resources
data "azurerm_resource_group" "existing" {
  name = var.existing_resource_group_name
}

data "azurerm_log_analytics_workspace" "existing" {
  name                = var.existing_workspace_name
  resource_group_name = data.azurerm_resource_group.existing.name
}

# Enable Microsoft Sentinel
resource "azurerm_log_analytics_solution" "sentinel" {
  solution_name         = "SecurityInsights"
  location             = data.azurerm_resource_group.existing.location
  resource_group_name  = data.azurerm_resource_group.existing.name
  workspace_resource_id = data.azurerm_log_analytics_workspace.existing.id
  workspace_name       = data.azurerm_log_analytics_workspace.existing.name

  plan {
    publisher = "Microsoft"
    product   = "OMSGallery/SecurityInsights"
  }

  tags = var.tags
}

##-----------------------------------------------------------------------------
## Labels module callled that will be used for naming and tags.
##-----------------------------------------------------------------------------
module "labels" {
  source      = "clouddrove/labels/azure"
  version     = "1.0.0"
  name        = var.name
  environment = var.environment
  managedby   = var.managedby
  label_order = var.label_order
  repository  = var.repository
}

resource "azurerm_sentinel_log_analytics_workspace_onboarding" "main" {
  count        = var.enabled && var.sentinel_enabled ? 1 : 0
  workspace_id = data.azurerm_log_analytics_workspace.existing.id
}

resource "azurerm_sentinel_alert_rule_ms_security_incident" "main" {
  count                      = var.enabled && var.ms_security_incident_enabled ? length(var.product_filter) : 0
  name                       = format("%s-ms-security-incident-alert-rule-%s", module.labels.id, count.index)
  log_analytics_workspace_id = azurerm_sentinel_log_analytics_workspace_onboarding.main[0].workspace_id
  product_filter             = element(var.product_filter, count.index)
  display_name               = element(var.display_name, count.index)
  severity_filter            = var.severity_filter
  enabled                    = var.ms_security_enabled
}

resource "azurerm_sentinel_data_connector_iot" "main" {
  count                      = var.enabled && var.dtc_iot_enabled ? 1 : 0
  name                       = format("%s-data-connector-azure-iot", module.labels.id)
  log_analytics_workspace_id = azurerm_sentinel_log_analytics_workspace_onboarding.main[0].workspace_id
  subscription_id            = var.subscription_id
}

resource "azurerm_sentinel_data_connector_azure_security_center" "main" {
  count                      = var.enabled && var.dtc_security_center_enabled ? 1 : 0
  name                       = format("%s-data-connector-azure-security-center", module.labels.id)
  log_analytics_workspace_id = azurerm_sentinel_log_analytics_workspace_onboarding.main[0].workspace_id
  subscription_id            = var.subscription_id

}
resource "azurerm_sentinel_data_connector_azure_active_directory" "main" {
  count                      = var.enabled && var.dtc_ad_enabled ? 1 : 0
  name                       = format("%s-data-connector-azure-ad", module.labels.id)
  log_analytics_workspace_id = azurerm_sentinel_log_analytics_workspace_onboarding.main[0].workspace_id
  tenant_id                  = var.tenant_id
}

resource "azurerm_sentinel_data_connector_azure_advanced_threat_protection" "main" {
  count                      = var.enabled && var.dtc_advanced_threat_protection_enabled ? 1 : 0
  name                       = format("%s-data-connector-advanced-threat-protection", module.labels.id)
  log_analytics_workspace_id = azurerm_sentinel_log_analytics_workspace_onboarding.main[0].workspace_id
  tenant_id                  = var.tenant_id
}

resource "azurerm_sentinel_data_connector_microsoft_cloud_app_security" "main" {
  count                      = var.enabled && var.dtc_ms_cloud_app_security_enabled ? 1 : 0
  name                       = format("%s-data-connector-microsoft-cloud-app-security", module.labels.id)
  log_analytics_workspace_id = azurerm_sentinel_log_analytics_workspace_onboarding.main[0].workspace_id
  alerts_enabled             = var.alerts_enabled
  discovery_logs_enabled     = var.discovery_logs_enabled
  tenant_id                  = var.tenant_id
}

resource "azurerm_sentinel_data_connector_microsoft_defender_advanced_threat_protection" "main" {
  count                      = var.enabled && var.dtc_ms_defender_advanced_threat_protection_enabled ? 1 : 0
  name                       = format("%s-data-connector-ms-defender-advanced-threat-protection", module.labels.id)
  log_analytics_workspace_id = azurerm_sentinel_log_analytics_workspace_onboarding.main[0].workspace_id
  tenant_id                  = var.tenant_id
}

resource "azurerm_sentinel_data_connector_microsoft_threat_protection" "main" {
  count                      = var.enabled && var.dtc_ms_threat_protection_enabled ? 1 : 0
  name                       = format("%s-data-connector-ms-threat-protection", module.labels.id)
  log_analytics_workspace_id = azurerm_sentinel_log_analytics_workspace_onboarding.main[0].workspace_id
  tenant_id                  = var.tenant_id
}

resource "azurerm_sentinel_data_connector_threat_intelligence" "main" {
  count                      = var.enabled && var.dtc_threat-intelligence_enabled ? 1 : 0
  name                       = format("%s-data-connector-threat-intelligence", module.labels.id)
  log_analytics_workspace_id = azurerm_sentinel_log_analytics_workspace_onboarding.main[0].workspace_id
}
