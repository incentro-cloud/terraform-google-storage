output "storage_bucket_name" {
  value       = module.storage.bucket.bucket.name
  description = "The storage bucket."
}
