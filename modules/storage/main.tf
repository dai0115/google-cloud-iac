resource "google_storage_bucket" "storage_public_dev" {
  cors {
    max_age_seconds = 86400
    method          = ["GET", "POST", "PUT", "OPTIONS"]
    origin          = ["*"]
    response_header = ["Content-Type", "Access-Control-Allow-Origin", "X-Requested-With", "x-goog-resumable"]
  }

  cors {
    max_age_seconds = 86400
    method          = ["GET", "POST", "PUT", "OPTIONS"]
    origin          = ["http://localhost:3001/"]
    response_header = ["Content-Type", "Access-Control-Allow-Origin", "X-Requested-With", "x-goog-resumable"]
  }

  force_destroy               = false
  location                    = "ASIA1"
  name                        = "iac-sandbox-public-dev-080801"
  public_access_prevention    = "inherited"
  storage_class               = "STANDARD"
  uniform_bucket_level_access = true
}
# terraform import google_storage_bucket.storage_public_dev storage-public-dev
