terragrunt_version_constraint = "v0.54.12"

skip = true

remote_state {
  backend = "gcs"
  config = {
    bucket = "iac-project-terraform-backend-sandbox-hateen0808"
    prefix = "${path_relative_to_include()}"
  }
}

generate "backend" {
  path      = "backend.tf"
  if_exists = "overwrite"
  contents = <<EOF
terraform {
  backend "gcs" {}

  required_version = "1.6.6"

  required_providers {
    google = {
      source = "hashicorp/google"
      version = "5.10.0"
    }
  }

}

provider "google" {
  project = "iac-sandbox-0808"
  region  = "asia-northeast1"
}
EOF
}

inputs = {
  environment = "sandbox"
  project = "project"
}