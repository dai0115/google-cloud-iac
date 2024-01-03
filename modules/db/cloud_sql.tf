# ---------------------------------------------------------------------------------------------------------------------
# Cloud SQL
# ---------------------------------------------------------------------------------------------------------------------
resource "google_sql_database_instance" "primary_database" {
  database_version = "MYSQL_8_0"
  name             = var.project
  deletion_protection = false # TODO: 本当はtrueだがテスト中のためfalseにしている

  settings {
    activation_policy = "ALWAYS"
    availability_type = "ZONAL" # TODO: prdはREGIONALになるはず

    backup_configuration {
      backup_retention_settings {
        retained_backups = var.backups_period
        retention_unit   = "COUNT"
      }

      binary_log_enabled             = true
      enabled                        = true
      location                       = "asia"
      start_time                     = "00:00" # TODO: JTCだと9時なので変更する？
      transaction_log_retention_days = var.transaction_log_retention_days
    }

    disk_autoresize       = true
    disk_autoresize_limit = 0 # 上限なし
    disk_size             = var.disk_size
    disk_type             = "PD_SSD"

    ip_configuration {
      ipv4_enabled    = false # TODO: この構成は誤ったものかもしれないので確認
      private_network = data.google_compute_network.vpc_default_network.self_link
    }

    location_preference {
      zone = "asia-northeast1-a"
    }

    pricing_plan = "PER_USE"
    tier         = var.tier
  }
}

resource "google_sql_user" "mysql_user" {
  instance = google_sql_database_instance.primary_database.name
  name     = data.google_secret_manager_secret_version.sql_user_name.secret_data
  password = data.google_secret_manager_secret_version.sql_user_password.secret_data
}

data "google_secret_manager_secret_version" "sql_user_name" {
  secret = "MYSQL_USER"
  version = "latest"
}

data "google_secret_manager_secret_version" "sql_user_password" {
  secret = "MYSQL_PASSWORD"
  version = "latest"
}

# ---------------------------------------------------------------------------------------------------------------------
# Private Service Connect
# ---------------------------------------------------------------------------------------------------------------------
resource "google_compute_global_address" "default_ip_range" {
  address       = "10.124.208.0"
  address_type  = "INTERNAL"
  name          = "default-ip-range"
  prefix_length = 20
  network       = "https://www.googleapis.com/compute/v1/projects/iac-sandbox-0808/global/networks/default"// TODO: change
  purpose       = "VPC_PEERING"
}

resource "google_project_service" "service_networking" {
  service            = "servicenetworking.googleapis.com"
  disable_on_destroy = false
}

resource "google_service_networking_connection" "private_connection" {
  network                 = data.google_compute_network.vpc_default_network.self_link
  service                 = "servicenetworking.googleapis.com"
  reserved_peering_ranges = [google_compute_global_address.default_ip_range.name]
}

data "google_compute_network" "vpc_default_network" {
  name = "default"
}


