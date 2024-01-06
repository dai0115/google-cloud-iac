# ---------------------------------------------------------------------------------------------------------------------
# REQUIRED PARAMETERS
# ---------------------------------------------------------------------------------------------------------------------

variable "environment" {
  description = "The name of the environment we're deploying to"
  type        = string
}

variable "project" {
  description = "The name of the project"
  type        = string
}

variable "location" {
  description = "The place where we're deploying to"
  type        = string
}

variable "max_instance_count" {
  description = "The maximum instances of cloud run service"
  type        = number
}

variable "sql_instance_connection_name" {
  description = "The name of instance connection"
  type        = string
}