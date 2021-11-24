# Bucket, objects, and IAM members

This example illustrates creating a storage bucket, an object, and assign a IAM member.

It will do the following:

- Create a storage bucket.
- Create an object.
- Assign a IAM member.

## Example usage

This is an example of the usage of the module.

```hcl
module "storage" {
  source  = "incentro-cloud/storage/google"
  version = "~> 0.1"

  project_id = var.project_id
  name       = "bucket-objects-iam-members"

  objects = [
    {
      name   = "string"
      content = "This is a string of data."
    }
  ]

  iam_members = [
    {
      member = "allUsers"
      role   = "roles/storage.objectViewer"
    }
  ]
}
```
