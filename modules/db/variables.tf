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

variable "backups_period" {
  description = "The period for retaining backups"
  type        = number
}

variable "transaction_log_retention_days" {
  description = "The number of days to retain transaction logs"
  type        = number
}

variable "disk_size" {
  description = "The disk size"
  type        = number
}

variable "tier" {
  description = "The machine type of the Cloud SQL instance"
  type        = string
}