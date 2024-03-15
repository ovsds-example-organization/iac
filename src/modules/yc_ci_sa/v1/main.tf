locals {
  name        = "github-${var.repository_name}"
  description = "Service account for CI auth in ${var.repository_name} repository."
}

resource "yandex_iam_service_account" "this" {
  folder_id = var.folder_id

  name        = local.name
  description = local.description
}

resource "yandex_iam_service_account_key" "this" {
  service_account_id = yandex_iam_service_account.this.id
}

resource "yandex_resourcemanager_cloud_iam_member" "this" {
  for_each = var.cloud_iam_members

  cloud_id = each.key
  role     = each.value
  member   = "serviceAccount:${yandex_iam_service_account.this.id}"
}
