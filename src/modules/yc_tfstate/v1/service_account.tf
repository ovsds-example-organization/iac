resource "yandex_iam_service_account" "this" {
  folder_id = yandex_resourcemanager_folder.this.id

  name        = var.service_account_name
  description = "Service account for controlling Terraform state"
}

resource "yandex_resourcemanager_folder_iam_member" "storage_editor" {
  folder_id = yandex_resourcemanager_folder.this.id

  role   = "storage.editor"
  member = "serviceAccount:${yandex_iam_service_account.this.id}"
}

resource "yandex_resourcemanager_folder_iam_member" "storage_configurer" {
  folder_id = yandex_resourcemanager_folder.this.id

  role   = "storage.configurer"
  member = "serviceAccount:${yandex_iam_service_account.this.id}"
}

resource "yandex_resourcemanager_folder_iam_member" "kms_encrypter" {
  folder_id = yandex_resourcemanager_folder.this.id

  role   = "kms.keys.encrypter"
  member = "serviceAccount:${yandex_iam_service_account.this.id}"
}

resource "yandex_resourcemanager_folder_iam_member" "kms_decrypter" {
  folder_id = yandex_resourcemanager_folder.this.id

  role   = "kms.keys.decrypter"
  member = "serviceAccount:${yandex_iam_service_account.this.id}"
}

resource "yandex_iam_service_account_static_access_key" "this" {
  service_account_id = yandex_iam_service_account.this.id

  description = "Static access key for object storage"

  lifecycle {
    prevent_destroy = true
  }
}

resource "yandex_lockbox_secret" "this" {
  folder_id = yandex_resourcemanager_folder.this.id

  name        = var.lockbox_name
  description = "keys for tfstate bucket"

  lifecycle {
    prevent_destroy = true
  }
}

resource "yandex_lockbox_secret_version" "this" {
  secret_id = yandex_lockbox_secret.this.id

  entries {
    key        = "ACCESS_KEY_ID"
    text_value = yandex_iam_service_account_static_access_key.this.access_key
  }

  entries {
    key        = "SECRET_ACCESS_KEY"
    text_value = yandex_iam_service_account_static_access_key.this.secret_key
  }
}
