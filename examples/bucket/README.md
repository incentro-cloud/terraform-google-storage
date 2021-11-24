# Bucket

This example illustrates creating a storage bucket.

It will do the following:

- Create a storage bucket.

## Example usage

This is an example of the usage of the module.

```hcl
module "storage" {
  source  = "incentro-cloud/storage/google"
  version = "~> 0.1"

  project_id    = var.project_id
  name          = "bucket"
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
}
```
