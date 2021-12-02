output "bucket" {
  value       = module.bucket
  description = "The storage bucket."
}

output "bucket_name" {
  value       = module.bucket.bucket.name
  description = "The name of the storage bucket."
}

output "objects" {
  value = module.objects
  description = "The objects."
}

output "objects_names" {
  value       = [for object in module.objects.objects : object.name]
  description = "The names of the objects."
}

output "bindings" {
  value = module.bindings
  description = "The IAM bindings."
}

output "members" {
  value = module.members
  description = "The IAM members."
}
