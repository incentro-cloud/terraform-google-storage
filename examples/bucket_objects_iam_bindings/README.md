# Bucket, objects, and IAM bindings

This example illustrates creating a storage bucket, an object, and a IAM binding.

It will do the following:

- Create a storage bucket.
- Create an object.
- Create a IAM binding.

## Example usage

This is an example of the usage of the module.

```hcl
module "storage" {
  source  = "incentro-cloud/storage/google"
  version = "~> 0.1"

  project_id = var.project_id
  name       = "bucket-objects-iam-bindings"

  objects = [
    {
      name   = "incentro"
      source = "./assets/incentro.png"
    }
  ]

  iam_bindings = [
    {
      members = ["allUsers"]
      role    = "roles/storage.objectViewer"
    }
  ]
}
```
