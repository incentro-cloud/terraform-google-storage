output "iam_bindings" {
  value       = google_storage_bucket_iam_binding.iam_bindings
  description = "The IAM bindings."
}
