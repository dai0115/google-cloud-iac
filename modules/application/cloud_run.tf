# ---------------------------------------------------------------------------------------------------------------------
# Cloud Run
# ---------------------------------------------------------------------------------------------------------------------
resource "google_cloud_run_v2_service" "default" {
  name     = "cloudrun-service"
  location = "asia-northeast1"
  ingress = "INGRESS_TRAFFIC_ALL" # TODO: stgとprdはINGRESS_TRAFFIC_INTERNAL_LOAD_BALANCER

  template {
    scaling {
      max_instance_count = var.max_instance_count
    }

    # cloud sql proxy経由での接続設定
    volumes {
      name = "cloudsql"
      cloud_sql_instance {
        instances = [var.sql_instance_connection_name]
      }
    }

    containers {
      image = "asia-northeast1-docker.pkg.dev/iac-sandbox-0808/google-cloud-iac/cloud_run_test:latest" # タグ名は必須
    }
  }

  traffic {
    type = "TRAFFIC_TARGET_ALLOCATION_TYPE_LATEST"
    percent = 100
  }
}


# TODO: stg, prdは設定が異なる
resource "google_cloud_run_service_iam_binding" "default" {
  location = google_cloud_run_v2_service.default.location
  service  = google_cloud_run_v2_service.default.name
  role     = "roles/run.invoker"
  members = [
    "allUsers"
  ]
}