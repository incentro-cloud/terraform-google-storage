# Storage module

![Cloud Build status](https://badger-tcppdqobjq-ew.a.run.app/build/status?project=examples-331911&id=437c5b6d-8b2a-4a41-a095-1f2e4c5cf42f "Cloud Build status")

Module for creating a storage bucket, objects, IAM bindings, and assigning IAM members.

This module supports creating/assigning:

- Storage bucket
- Objects
- IAM bindings
- IAM members

## Usage

This is an example of the usage of the module. More examples can be found in under 'examples'.

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

  objects = [
    {
      name   = "incentro"
      source = "./assets/incentro.png"
    }
  ]

  iam_members = [
    {
      member = "allUsers"
      role    = "roles/storage.objectViewer"
    }
  ]
}
```

## Inputs

Most inputs map to the supported arguments. Links to the official documentation are included.

### Storage bucket

Submodule for creating a storage bucket.

[Click here](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/storage_bucket "google_storage_bucket") for the **google_storage_bucket** documentation.

| Name | Type | Default | Description |
|---|---|---|---|
| `project_id` | string |  | Required. The project identifier. |
| `name` | string |  | Required. The name of the storage bucket. |
| `location` | string | "EU" | Optional. The location of the storage bucket. |
| `storage_class` | string | "STANDARD" | Optional. The storage class of the storage bucket. |
| `uniform_bucket_level_access` | bool | true | Optional. When set to 'true', enables uniform bucket-level access. |
| `force_destroy` | bool | false | Optional. When set to 'true', deleting a storage bucket will delete all contained objects. |
| `versioning` | bool | false | Optional. When set to 'true', versioning is fully enabled for this bucket. |
| `labels` | any | {} | Optional. The Key/value label pairs of the storage bucket. |
| `retention_policy` | any | {} | Optional. The retention policy for how long objects in the storage bucket should be retained. |
| `encryption` | any | {} | Optional. The storage bucket's encryption configuration. |
| `cors` | any | {} | Optional. The storage bucket's Cross-Origin Resource Sharing (CORS) configuration. |
| `lifecycle_rules` | {} | [] | Optional. The storage bucket's Lifecycle Rules configuration. |
| `logging` | any | {} | Optional. The storage bucket's logging configuration. |
| `website` | any | {} | Optional. The configuration if the storage bucket acts as a website. |
| `objects` | any | [] | Optional. The list of objects. |
| `iam_bindings` | any | [] | Optional. The list of IAM bindings. |
| `iam_members` | any | [] | Optional. The list of IAM members. |

### Objects

Submodule for creating objects.

[Click here](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/storage_bucket_object "google_storage_bucket_object") for the **google_storage_bucket_object** documentation.

| Name | Type | Default | Description |
|---|---|---|---|
| `name` | string |  | Required. The name/path of the object. |
| `content` | string | null | Optional. Either `content` or `source` has to be specified. The name/path of the object. |
| `source` | string | null | Optional. Either `source` or `content` has to be specified. The source of the object. |
| `bucket` | string | module.bucket | Optional. The storage bucket for the object. |

### IAM bindings

Submodule for creating IAM bindings (authoritative).

[Click here](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/storage_bucket_iam#google_storage_bucket_iam_binding "google_storage_bucket_iam_binding") for the **google_storage_bucket_iam_binding** documentation.

| Name | Type | Default | Description |
|---|---|---|---|
| `bucket` | string | module.bucket | Optional. The storage bucket for the IAM binding. |
| `members` | any |  | Required. The identities that will be granted the privilege in role. |
| `role` | string |  | Required. The role that should be applied. Only one IAM binding can be used per role. |
| `condition` | any | null | Optional. The condition for the IAM binding. |

### IAM members

Submodule for assigning IAM members (non-authoritative).

[Click here](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/storage_bucket_iam#google_storage_bucket_iam_member "google_storage_bucket_iam_member") for the **google_storage_bucket_iam_member** documentation.

| Name | Type | Default | Description |
|---|---|---|---|
| `bucket` | string | module.bucket | Optional. The storage bucket for the IAM member assignment. |
| `member` | any |  | Required. The identities that will be granted the privilege in role. |
| `role` | string |  | Required. The role that should be applied. |
| `condition` | any | null | Optional. The condition for the IAM member assignment. |

## Outputs

| Name | Description |
|---|---|
| `bucket` | The storage bucket. |
| `bucket_name` | The name of the storage bucket. |
| `objects` | The objects. |
| `objects_names` | The names of the objects. |
| `iam_bindings` | The IAM bindings. |
| `iam_members` | The IAM members. |
