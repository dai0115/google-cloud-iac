include "root" {
  path = find_in_parent_folders()
}

terraform {
  source = "../../../modules/application"
}

dependency "db" {
  config_path = "../db"
}

inputs = {
    sql_instance_connection_name = dependency.db.outputs.sql_instance_connection_name
    max_instance_count = 3
}