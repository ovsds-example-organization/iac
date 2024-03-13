locals {
  folder_name  = "tfstate"
  sa_name      = "tfstate-sa"
  lockbox_name = "tfstate_bucket_keys"

  tfstate_secrets = {
    for secret in yandex_lockbox_secret_version.tfstate_keys.entries :
    secret.key => secret.text_value
  }
}

resource "yandex_resourcemanager_folder" "tfstate" {
  cloud_id = var.cloud_id

  name        = local.folder_name
  description = "Folder for storing Terraform state"
}

resource "yandex_iam_service_account" "tfstate" {
  folder_id = yandex_resourcemanager_folder.tfstate.id

  name        = local.sa_name
  description = "Service account for controlling Terraform state"
}

resource "yandex_resourcemanager_folder_iam_member" "tfstate_storage_editor" {
  folder_id = yandex_resourcemanager_folder.tfstate.id

  role   = "storage.editor"
  member = "serviceAccount:${yandex_iam_service_account.tfstate.id}"
}

resource "yandex_iam_service_account_static_access_key" "tfstate" {
  service_account_id = yandex_iam_service_account.tfstate.id

  description = "Static access key for object storage"
}

resource "yandex_storage_bucket" "tfstate" {
  folder_id = yandex_resourcemanager_folder.tfstate.id

  bucket     = var.bucket_name
  access_key = yandex_iam_service_account_static_access_key.tfstate.access_key
  secret_key = yandex_iam_service_account_static_access_key.tfstate.secret_key

  versioning {
    enabled = true
  }
}

resource "yandex_lockbox_secret" "tfstate_keys" {
  folder_id = yandex_resourcemanager_folder.tfstate.id

  name        = local.lockbox_name
  description = "keys for tfstate bucket"
}

resource "yandex_lockbox_secret_version" "tfstate_keys" {
  secret_id = yandex_lockbox_secret.tfstate_keys.id

  entries {
    key        = "ACCESS_KEY_ID"
    text_value = yandex_iam_service_account_static_access_key.tfstate.access_key
  }

  entries {
    key        = "SECRET_ACCESS_KEY"
    text_value = yandex_iam_service_account_static_access_key.tfstate.secret_key
  }
}
