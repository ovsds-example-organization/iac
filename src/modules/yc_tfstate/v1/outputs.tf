output "secrets" {
  value       = local.tfstate_secrets
  description = "Secrets to tfstate bucket"
  sensitive   = true
}
