output "secrets" {
  value = {
    for secret in yandex_lockbox_secret_version.this.entries :
    secret.key => secret.text_value
  }
  description = "Secrets to tfstate bucket"
  sensitive   = true
}
