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
# STORAGE BUCKET AND IAM BINDINGS
# ---------------------------------------------------------------------------------------------------------------------

module "storage" {
  source = "../../"

  project_id = var.project_id

  name = "bucket-iam-bindings"

  iam_bindings = [
    {
      members = ["allUsers"]
      role    = "roles/storage.objectViewer"
    },
    {
      members = ["allUsers"]
      role    = "roles/storage.objectAdmin"
    }
  ]
}
