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
  bindings = [
    for binding in var.bindings : {
      bucket    = lookup(binding, "bucket", module.bucket.bucket.name)
      members   = binding.members
      role      = binding.role
      condition = lookup(binding, "condition", null)
    }
  ]
}

module "bindings" {
  source = "./modules/bindings"

  bindings = local.bindings
}

# ---------------------------------------------------------------------------------------------------------------------
# IAM MEMBERS (NON-AUTHORITATIVE)
# ---------------------------------------------------------------------------------------------------------------------

locals {
  members = [
    for member in var.members : {
      bucket    = lookup(member, "bucket", module.bucket.bucket.name)
      member    = member.member
      role      = member.role
      condition = lookup(member, "condition", null)
    }
  ]
}

module "members" {
  source = "./modules/members"

  members = local.members
}
