output "service_account" {
  value       = yandex_iam_service_account.this
  description = "Service account created"
}

output "key_id" {
  value       = yandex_iam_service_account_key.this.id
  description = "Service account key id"
}

output "public_key" {
  value       = yandex_iam_service_account_key.this.public_key
  description = "Service account public key"
}

output "private_key" {
  value       = yandex_iam_service_account_key.this.private_key
  description = "Service account private key"
}
