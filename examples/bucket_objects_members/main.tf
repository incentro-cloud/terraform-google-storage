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
# STORAGE BUCKET AND IAM MEMBERS
# ---------------------------------------------------------------------------------------------------------------------

module "storage" {
  source = "../../"

  project_id = var.project_id
  name       = "bucket-objects-iam-members"

  objects = [
    {
      name   = "string"
      content = "This is a string of data."
    }
  ]

  members = [
    {
      member = "allUsers"
      role   = "roles/storage.objectViewer"
    }
  ]
}
