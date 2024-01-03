include "root" {
  path = find_in_parent_folders()
}

terraform {
  source = "../../../modules/db"
}

inputs = {
  backups_period = 30
  transaction_log_retention_days = 7
  disk_size = 100
  tier = "db-f1-micro"
}