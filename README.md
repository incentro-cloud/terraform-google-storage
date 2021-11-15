# Storage module

![Cloud Build status](https://badger-tcppdqobjq-ew.a.run.app/build/status?project=examples-331911&id=437c5b6d-8b2a-4a41-a095-1f2e4c5cf42f "Cloud Build status")

Module for creating storage buckets.

This module supports creating:

- Storage buckets

## Usage

```hcl
module "storage" {
  source = "github.com/incentro-cloud/terraform-google-storage"
  
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
```