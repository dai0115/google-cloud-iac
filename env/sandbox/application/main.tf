terraform {
  required_version = "1.6.6"

  required_providers {
    google = {
      source = "hashicorp/google"
      version = "5.10.0"
    }
  }

  backend "gcs" {
    bucket = "iac-project-terraform-backend-sandbox-hateen0808"
    prefix = "terraform/state/application"
  }
}

provider "google" {
  project = "iac-sandbox-0808"
  region  = "asia-northeast1"
}

module "application" {
  source = "../../../modules/application"
}

import {
  id = "asia-northeast1/google-cloud-iac"
  to = module.application.google_artifact_registry_repository.google_cloud_artifact_registry_repository
}