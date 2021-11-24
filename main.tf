# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# STORAGE
# Module for creating a storage bucket, objects, IAM bindings, and assigning IAM members.
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

# ---------------------------------------------------------------------------------------------------------------------
# STORAGE BUCKET
# ---------------------------------------------------------------------------------------------------------------------

module "bucket" {
  source = "./modules/bucket"

  name                        = var.name
  location                    = var.location
  project_id                  = var.project_id
  storage_class               = var.storage_class
  uniform_bucket_level_access = var.uniform_bucket_level_access
  force_destroy               = var.force_destroy
  versioning                  = var.versioning
  labels                      = var.labels
  retention_policy            = var.retention_policy
  encryption                  = var.encryption
  cors                        = var.cors
  lifecycle_rules             = var.lifecycle_rules
  logging                     = var.logging
  website                     = var.website
}

# ---------------------------------------------------------------------------------------------------------------------
# OBJECTS
# ---------------------------------------------------------------------------------------------------------------------

locals {
  objects = [
    for object in var.objects : {
      name    = object.name
      content = lookup(object, "content", null)
      source  = lookup(object, "source", null)
      bucket  = lookup(object, "bucket", module.bucket.bucket.name)
    }
  ]
}

module "objects" {
  source = "./modules/objects"

  objects = local.objects
}

# ---------------------------------------------------------------------------------------------------------------------
# IAM BINDINGS (AUTHORITATIVE)
# ---------------------------------------------------------------------------------------------------------------------

locals {
  iam_bindings = [
    for x in var.iam_bindings : {
      bucket    = lookup(x, "bucket", module.bucket.bucket.name)
      members   = x.members
      role      = x.role
      condition = lookup(x, "condition", null)
    }
  ]
}

module "iam_bindings" {
  source = "./modules/iam_bindings"

  iam_bindings = local.iam_bindings
}

# ---------------------------------------------------------------------------------------------------------------------
# IAM MEMBERS (NON-AUTHORITATIVE)
# ---------------------------------------------------------------------------------------------------------------------

locals {
  iam_members = [
    for x in var.iam_members : {
      bucket    = lookup(x, "bucket", module.bucket.bucket.name)
      member    = x.member
      role      = x.role
      condition = lookup(x, "condition", null)
    }
  ]
}

module "iam_members" {
  source = "./modules/iam_members"

  iam_members = local.iam_members
}
