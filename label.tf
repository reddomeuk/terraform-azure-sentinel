variable "name" {
  type        = string
  default     = ""
  description = "Name of the resource."
}

variable "repository" {
  type        = string
  default     = "https://github.com/reddomeuk/terraform-azure-sentinel"
  description = "Terraform current module repo"
}

variable "environment" {
  type        = string
  default     = "test"
  description = "Environment (e.g. `prod`, `dev`, `staging`)."
}

variable "label_order" {
  type        = list(any)
  default     = ["name", "environment"]
  description = "Label order, e.g. `name`,`environment`"
}

variable "managedby" {
  type        = string
  default     = "reddome@reddome.co.uk"
  description = "ManagedBy, eg 'RedDome'."
}

variable "enabled" {
  type        = bool
  default     = true
  description = "Flag to control module creation."
}