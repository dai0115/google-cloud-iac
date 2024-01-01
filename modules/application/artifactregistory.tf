resource "google_artifact_registry_repository" "google_cloud_artifact_registry_repository" {
  location      = "asia-northeast1"
  repository_id = "google-cloud-iac"
  description   = "google-cloud-iac"
  format        = "DOCKER"
}