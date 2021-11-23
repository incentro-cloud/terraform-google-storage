# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# IAM MEMBERS
# Submodule for assigning storage IAM bucket members.
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

# ---------------------------------------------------------------------------------------------------------------------
# TERRAFORM CONFIGURATION
# ---------------------------------------------------------------------------------------------------------------------

terraform {
  required_version = ">= 1.0.0"

  required_providers {
    google = {
      source  = "hashicorp/google"
      version = ">= 4.0.0"
    }
    google-beta = {
      source  = "hashicorp/google-beta"
      version = ">= 4.0.0"
    }
  }
}

# ---------------------------------------------------------------------------------------------------------------------
# MEMBERS
# ---------------------------------------------------------------------------------------------------------------------

resource "google_storage_bucket_iam_member" "iam_members" {
  provider = google-beta

  for_each = { for x in var.iam_members : "${x.member}/${x.role}" => x }
  bucket   = each.value.bucket
  member   = each.value.member
  role     = each.value.role

  dynamic "condition" {
    for_each = lookup(each.value, "condition") == null ? [] : [each.value.condition]
    content {
      title       = condition.value.title
      description = lookup(condition.value, "description", null)
      expression  = condition.value.expression
    }
  }
}
