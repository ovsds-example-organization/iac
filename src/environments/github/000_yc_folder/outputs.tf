output "yc_folder_id" {
  value       = yandex_resourcemanager_folder.this.id
  description = "ID of the created Yandex.Cloud folder."
}

output "github_robot_admin_token" {
  value       = lookup(local.github_robot_secrets, "ADMIN_TOKEN", null)
  description = "GitHub robot admin token."
  sensitive   = true
}

output "github_robot_secrets" {
  value       = local.github_robot_secrets
  description = "GitHub robot secrets."
  sensitive   = true
}
