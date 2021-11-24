# Storage module

![Cloud Build status](https://badger-tcppdqobjq-ew.a.run.app/build/status?project=examples-331911&id=437c5b6d-8b2a-4a41-a095-1f2e4c5cf42f "Cloud Build status")

Module for creating storage buckets.

This module supports creating:

- Storage bucket
- Objects
- IAM bindings
- IAM members

## Usage

```hcl

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
| `retention_policy` | any | null | Optional. The retention policy for how long objects in the storage bucket should be retained. |
| `encryption` | any | null | Optional. The storage bucket's encryption configuration. |
| `cors` | any | null | Optional. The storage bucket's Cross-Origin Resource Sharing (CORS) configuration. |
| `lifecycle_rules` | any | [] | Optional. The storage bucket's Lifecycle Rules configuration. |
| `logging` | any | null | Optional. The storage bucket's logging configuration. |
| `website` | any | null | Optional. The configuration if the storage bucket acts as a website. |
| `objects` | any | [] | Optional. The list of objects. |
| `iam_bindings` | any | [] | Optional. The list of IAM bindings. |
| `iam_members` | any | [] | Optional. The list of IAM members. |

### Objects

Submodule for creating objects.

[Click here](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/storage_bucket_object "google_storage_bucket_object") for the **google_storage_bucket_object** documentation.

| Name | Type | Default | Description |
|---|---|---|---|
| `project_id` | string |  | Required. The project identifier. |
| `` |  |  |  |

### IAM bindings

Submodule for creating IAM bindings.

[Click here](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/storage_bucket_iam#google_storage_bucket_iam_binding "google_storage_bucket_iam_binding") for the **google_storage_bucket_iam_binding** documentation.

| Name | Type | Default | Description |
|---|---|---|---|
| `project_id` | string |  | Required. The project identifier. |
| `` |  |  |  |

### IAM members

Submodule for assigning IAM members.

[Click here](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/storage_bucket_iam#google_storage_bucket_iam_member "google_storage_bucket_iam_member") for the **google_storage_bucket_iam_member** documentation.

| Name | Type | Default | Description |
|---|---|---|---|
| `project_id` | string |  | Required. The project identifier. |
| `` |  |  |  |

## Outputs

| Name | Description |
|---|---|
| `` |  |
