# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# STORAGE
# Module for creating storage buckets.
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

# ---------------------------------------------------------------------------------------------------------------------
# STORAGE BUCKETS
# ---------------------------------------------------------------------------------------------------------------------

locals {
  buckets = [
    for x in var.buckets : {
      name                        = x.name
      location                    = lookup(x, "location", "EU")
      storage_class               = lookup(x, "storage_class", "STANDARD")
      uniform_bucket_level_access = lookup(x, "uniform_bucket_level_access", true)
      force_destroy               = lookup(x, "force_destroy", false)
      versioning                  = lookup(x, "versioning", false)
      labels                      = lookup(x, "labels", {})
      retention_policy            = lookup(x, "retention_policy", null)
      encryption                  = lookup(x, "encryption", null)
      cors                        = lookup(x, "cors", null)
      lifecycle_rules             = lookup(x, "lifecycle_rules", [])
      logging                     = lookup(x, "logging", null)
    }
  ]
}

module "buckets" {
  source     = "./modules/buckets"
  project_id = var.project_id
  buckets    = local.buckets
}
