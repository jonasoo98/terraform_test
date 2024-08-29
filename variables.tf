variable "resource_group_name" {
  type    = string
  default = "jonas_resource_group"
}

variable "location" {
  type    = string
  default = "West Europe"
}

variable "tenant_id" {
  type = string
}

variable "subscription_id" {
  type = string
}

variable "client_id" {
  type = string
}

variable "client_secret" {
  type      = string
  sensitive = true
}