resource "github_actions_secret" "secrets" {
  for_each = var.secrets

  repository      = var.repository_name
  secret_name     = each.key
  plaintext_value = each.value
}

