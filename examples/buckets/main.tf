# ---------------------------------------------------------------------------------------------------------------------
# TERRAFORM CONFIGURATION
# ---------------------------------------------------------------------------------------------------------------------

terraform {
  required_version = "~> 1.0"

  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "~> 4.0"
    }
    google-beta = {
      source  = "hashicorp/google-beta"
      version = "~> 4.0"
    }
  }
}

# ---------------------------------------------------------------------------------------------------------------------
# STORAGE BUCKETS
# ---------------------------------------------------------------------------------------------------------------------

module "storage" {
  source = "../../"

  project_id = var.project_id

  buckets = [
    {
      name          = "example-01"
      location      = "EU"
      storage_class = "STANDARD"

      labels = {
        environment = "examples"
      }

      retention_policy = {
        retention_period = 365
      }

      cors = {
        origin          = ["http://examples.com"]
        method          = ["GET", "HEAD", "PUT", "POST", "DELETE"]
        response_header = ["*"]
        max_age_seconds = 3600
      }

      lifecycle_rules = [
        {
          action = {
            type = "Delete"
          }
          condition = {
            age = 365
          }
        }
      ]
    },
    {
      name                        = "example-02"
      location                    = "EU"
      storage_class               = "STANDARD"
      uniform_bucket_level_access = false
      force_destroy               = true
      versioning                  = true
    }
  ]
}
