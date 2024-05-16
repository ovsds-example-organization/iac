output "yc_folder_id" {
  value       = module.tf_state.yc_folder_id
  description = "YC folder id"
}

output "access_key_id" {
  value       = module.tf_state.access_key_id
  description = "Access key id"
  sensitive   = true
}

output "secret_access_key" {
  value       = module.tf_state.secret_access_key
  description = "Secret access key"
  sensitive   = true
}
