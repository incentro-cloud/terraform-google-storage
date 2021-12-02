variable "project_id" {
  type        = string
  description = "Required. The project identifier."
}

variable "name" {
  type        = string
  description = "Required. The name of the storage bucket."
}

variable "location" {
  type        = string
  description = "Optional. The location of the storage bucket."
  default     = "EU"
}

variable "storage_class" {
  type        = string
  description = "Optional. The storage class of the storage bucket."
  default     = "STANDARD"
}

variable "uniform_bucket_level_access" {
  type        = bool
  description = "Optional. When set to 'true', enables uniform bucket-level access."
  default     = true
}

variable "force_destroy" {
  type        = bool
  description = "Optional. When set to 'true', deleting a storage bucket will delete all contained objects."
  default     = false
}

variable "versioning" {
  type        = bool
  description = "Optional. When set to 'true', versioning is fully enabled for this bucket."
  default     = false
}

variable "labels" {
  type        = any
  description = "Optional. The Key/value label pairs of the storage bucket."
  default     = {}
}

variable "retention_policy" {
  type        = any
  description = "Optional. The retention policy for how long objects in the storage bucket should be retained."
  default     = {}
}

variable "encryption" {
  type        = any
  description = "Optional. The storage bucket's encryption configuration."
  default     = {}
}

variable "cors" {
  type        = any
  description = "Optional. The storage bucket's Cross-Origin Resource Sharing (CORS) configuration."
  default     = {}
}

variable "lifecycle_rules" {
  type        = any
  description = "Optional. The storage bucket's Lifecycle Rules configuration."
  default     = []
}

variable "logging" {
  type        = any
  description = "Optional. The storage bucket's logging configuration."
  default     = {}
}

variable "website" {
  type        = any
  description = "Optional. The configuration if the storage bucket acts as a website."
  default     = {}
}

variable "objects" {
  type        = any
  description = "Optional. The list of objects."
  default     = []
}

variable "bindings" {
  type        = any
  description = "Optional. The list of IAM bindings."
  default     = []
}

variable "members" {
  type        = any
  description = "Optional. The list of IAM members."
  default     = []
}
