output "yc_folder_id" {
  value       = yandex_resourcemanager_folder.this.id
  description = "YC folder id"
}

output "access_key_id" {
  value       = yandex_iam_service_account_static_access_key.this.access_key
  description = "Access key id"
  sensitive   = true
}

output "secret_access_key" {
  value       = yandex_iam_service_account_static_access_key.this.secret_key
  description = "Secret access key"
  sensitive   = true
}
