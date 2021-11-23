variable "project_id" {
  type        = string
  description = "The project identifier."
}

variable "name" {
  type        = string
  description = ""
}

variable "location" {
  type        = string
  description = ""
  default     = "EU"
}

variable "storage_class" {
  type        = string
  description = ""
  default     = "STANDARD"
}

variable "uniform_bucket_level_access" {
  type        = bool
  description = ""
  default     = true
}

variable "force_destroy" {
  type        = bool
  description = ""
  default     = false
}

variable "versioning" {
  type        = bool
  description = ""
  default     = false
}

variable "labels" {
  type        = any
  description = ""
  default     = {}
}

variable "retention_policy" {
  type        = any
  description = ""
  default     = null
}

variable "encryption" {
  type        = any
  description = ""
  default     = null
}

variable "cors" {
  type        = any
  description = ""
  default     = null
}

variable "lifecycle_rules" {
  type        = any
  description = ""
  default     = []
}

variable "logging" {
  type        = any
  description = ""
  default     = null
}

variable "website" {
  type        = any
  description = ""
  default     = null
}

variable "objects" {
  type        = any
  description = "The objects."
  default     = []
}

variable "policies" {
  type        = any
  description = "The IAM policies."
  default     = []
}

variable "iam_bindings" {
  type        = any
  description = "The IAM bindings."
  default     = []
}

variable "iam_members" {
  type        = any
  description = "The IAM members."
  default     = []
}
