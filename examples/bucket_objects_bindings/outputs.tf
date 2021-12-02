output "storage_bucket_name" {
  value       = module.storage.bucket_name
  description = "The storage bucket name."
}

output "storage_object_name" {
  value       = module.storage.objects_names[0]
  description = "The name of the first object."
}
