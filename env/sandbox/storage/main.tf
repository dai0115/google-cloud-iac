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
    prefix = "terraform/state/storage"
  }
}

provider "google" {
  project = "iac-sandbox-0808"
  region  = "asia-northeast1"
}

module "storage" {
  source = "../../../modules/storage"
}
