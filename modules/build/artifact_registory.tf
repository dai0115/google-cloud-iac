resource "google_artifact_registry_repository" "google_cloud_artifact_registry_repository" {
  location      = var.location
  repository_id = "google-cloud-iac"
  format        = "DOCKER"
}