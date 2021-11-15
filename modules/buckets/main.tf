# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# STORAGE BUCKETS
# Submodule for creating storage buckets.
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
# STORAGE BUCKETS
# ---------------------------------------------------------------------------------------------------------------------

resource "google_storage_bucket" "buckets" {
  for_each                    = { for x in var.buckets : x.name => x }
  name                        = "${var.project_id}-${each.value.name}"
  project                     = var.project_id
  location                    = each.value.location
  storage_class               = each.value.storage_class
  uniform_bucket_level_access = each.value.uniform_bucket_level_access
  labels                      = each.value.labels
  force_destroy               = each.value.force_destroy

  versioning {
    enabled = each.value.versioning
  }

  dynamic "retention_policy" {
    for_each = lookup(each.value, "retention_policy") == null ? [] : [each.value.retention_policy]

    content {
      is_locked        = lookup(retention_policy.value, "is_locked", false)
      retention_period = lookup(retention_policy.value, "retention_period", 400)
    }
  }

  dynamic "encryption" {
    for_each = lookup(each.value, "encryption") == null ? [] : [each.value.encryption]

    content {
      default_kms_key_name = encryption.value.default_kms_key_name
    }
  }

  dynamic "cors" {
    for_each = lookup(each.value, "cors") == null ? [] : [each.value.cors]

    content {
      origin          = lookup(cors.value, "origin", null)
      method          = lookup(cors.value, "method", null)
      response_header = lookup(cors.value, "response_header", null)
      max_age_seconds = lookup(cors.value, "max_age_seconds", null)
    }
  }

  dynamic "lifecycle_rule" {
    for_each = lookup(each.value, "lifecycle_rules", [])
    content {
      action {
        type          = lifecycle_rule.value.action.type
        storage_class = lookup(lifecycle_rule.value.action, "storage_class", null)
      }
      condition {
        age                   = lookup(lifecycle_rule.value.condition, "age", null)
        created_before        = lookup(lifecycle_rule.value.condition, "created_before", null)
        with_state            = lookup(lifecycle_rule.value.condition, "with_state", lookup(lifecycle_rule.value.condition, "is_live", false) ? "LIVE" : null)
        matches_storage_class = lookup(lifecycle_rule.value.condition, "matches_storage_class", null)
        num_newer_versions    = lookup(lifecycle_rule.value.condition, "num_newer_versions", null)
      }
    }
  }

  dynamic "logging" {
    for_each = lookup(each.value, "logging") == null ? [] : [each.value.logging]

    content {
      log_bucket        = logging.value.log_bucket
      log_object_prefix = lookup(logging.value, "log_object_prefix", null)
    }
  }
}
