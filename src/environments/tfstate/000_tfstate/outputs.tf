output "tfstate_secrets" {
  value       = module.tf_state.secrets
  description = "Secrets to tfstate bucket"
  sensitive   = true
}
