data "azurerm_subscription" "current" {}

# ======================================================================================
# WebApp App Service Plan
# ======================================================================================

resource "azurerm_app_service_plan" "app_service_plan_webapp" {
  name                       = "${var.application}-plan-${var.environment}-${var.location_short_name}"
  location                   = azurerm_resource_group.rg.location
  resource_group_name        = azurerm_resource_group.rg.name
  kind                       = "app"
  reserved                   = false

  sku {
    tier     = var.app_service_plan_tier
    size     = var.app_service_plan_size
    capacity = var.app_service_plan_capacity
  }
  
  tags = {
    displayName: "${var.application}-plan-${var.environment}-${var.location_short_name}"
  }
}

# ======================================================================================
# Application Insights
# ======================================================================================

resource "azurerm_application_insights" "app-insights" {
  name                = "${var.application}-ai-${var.environment}-${var.location_short_name}"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  application_type    = "web"
  retention_in_days   = 90
  tags  = {
    "hidden-link:/subscriptions/${data.azurerm_subscription.current.subscription_id}/resourceGroups/${var.resource_group_name}-${var.environment}-${var.location_short_name}/providers/Microsoft.Web/sites/${var.application}-${var.environment}-${var.location_short_name}": "Resource"
    product: var.application
  }
}

# ======================================================================================
# WebApp
# ======================================================================================

resource "azurerm_app_service" "webapp" {
  name                    = "${var.application}-${var.environment}-${var.location_short_name}"
  location                = azurerm_resource_group.rg.location
  resource_group_name     = azurerm_resource_group.rg.name
  https_only              = true
  enabled                 = true
  client_affinity_enabled = false
  tags                    = {
    product: var.application
  }

  app_service_plan_id = azurerm_app_service_plan.app_service_plan_webapp.id

  site_config {
    always_on        = true 
    scm_type         = "VSTSRM"
  }

   identity {
    type = "SystemAssigned"
  }
  app_settings = {
    "APPINSIGHTS_INSTRUMENTATIONKEY" = azurerm_application_insights.app-insights.instrumentation_key
     "XDT_MicrosoftApplicationInsights_Mode" = "default"
    "ApplicationInsightsAgent_EXTENSION_VERSION"="~2"
    "ASPNETCORE_ENVIRONMENT" = "Development"    
  }
}