# 第一世代のcloud build repositoryを利用しているためリポジトリはterraformで管理していない
# TODO 第2世代にアップデートしたい際には、terraformで管理したい
# https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/cloudbuildv2_repository

resource "google_cloudbuild_trigger" "deploy_to_cloud_run" {
  location = "global"
  name     = "${var.environment}-deploy-to-cloud-run"
  filename = "cloudbuild-dev.yml"

  github {
    owner = "dai0115"
    name  = "google-cloud-iac"
    push {
      branch = "^main$"
    }
  }

  include_build_logs = "INCLUDE_BUILD_LOGS_WITH_STATUS"
}