# ---------------------------------------------------------------------------------------------------------------------
# REQUIRED PARAMETERS
# ---------------------------------------------------------------------------------------------------------------------

variable "environment" {
  description = "The name of the environment we're deploying to"
  type        = string
}

variable "location" {
  description = "The place where we're deploying to"
  type        = string
}