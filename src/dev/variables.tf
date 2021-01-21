variable "location" {
   type   = string
}

variable "location_short_name" {
  type   = string
}

variable "zone" {
    type    = list
}

variable "tags" {
  description = "A map of the tags to use for the resources that are deployed"
  type        = map(string)  
}

variable "tenantid" {
 type   = string
}

variable "resource_group_name" {
  type   = string
}

variable "application" {
 type   = string
}

variable "application_short" {
  type   = string
}

variable "environment" {
  type   = string
}

variable "environment_short_name" {
  type   = string
}

# App Service Plan Capacity Settings

variable "app_service_plan_tier" {
  description = "Specifies the plan's pricing tier"
  type   = string
}

variable "app_service_plan_size" {
  description = "Specifies the plan's SKU size"
  type   = string
}

variable "app_service_plan_capacity" {
  description = "Specifies the initial capacity for the app service plan"
  type    = number
}

