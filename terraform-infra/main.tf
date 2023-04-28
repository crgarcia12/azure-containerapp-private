variable "prefix" {}
variable "location" {}

locals {
  log_analytics_workspace_name = "${var.prefix}-la"
}

resource "azurerm_log_analytics_workspace" "log_analytics_workspace" {
  name                = local.log_analytics_workspace_name
  location            = var.location
  resource_group_name = "your_resource_group_name"
  sku                 = "PerGB2018"
  retention_in_days   = 30
}

resource "azurerm_app_environment" "environment" {
  name                = "${var.prefix}-aca-env"
  location            = var.location
  resource_group_name = "your_resource_group_name"
  app_logs_configuration {
    destination = "log-analytics"
    log_analytics_configuration {
      customer_id = azurerm_log_analytics_workspace.log_analytics_workspace.customer_id
      shared_key  = azurerm_log_analytics_workspace.log_analytics_workspace.primary_shared_key
    }
  }
}

resource "azurerm_app_container" "nginxcontainerapp" {
  name                = "nginxcontainerapp"
  location            = var.location
  resource_group_name = "your_resource_group_name"
  managed_environment_id = azurerm_app_environment.environment.id
  configuration {
    ingress {
      external = true
      target_port = 80
    }
  }
  template {
    containers {
      image = "nginx"
      name  = "nginxcontainerapp"
      resources {
        cpu    = 0.5
        memory = 1.0
      }
    }
    scale {
      min_replicas = 1
      max_replicas = 1
    }
  }
}
