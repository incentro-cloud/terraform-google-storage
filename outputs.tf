output "buckets" {
  value       = module.buckets.buckets
  description = "The storage buckets."
}

output "buckets_names" {
  value       = [for x in module.buckets.buckets : x.name]
  description = "The names of the storage buckets."
}
