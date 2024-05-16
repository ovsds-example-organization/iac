resource "yandex_resourcemanager_folder" "this" {
  cloud_id = var.yc_cloud_id

  name        = var.yc_folder_name
  description = "Folder for storing Terraform state"
}

resource "yandex_kms_symmetric_key" "this" {
  folder_id = yandex_resourcemanager_folder.this.id

  name                = var.bucket_name
  description         = "Key for encrypting Terraform state for bucket ${var.bucket_name}"
  default_algorithm   = "AES_256"
  deletion_protection = true
  rotation_period     = "${365 * 24}h0m0s" # 1 year

  lifecycle {
    prevent_destroy = true
  }
}

resource "yandex_storage_bucket" "this" {
  folder_id = yandex_resourcemanager_folder.this.id

  bucket     = var.bucket_name
  max_size   = var.bucket_max_size * 1024 * 1024 # MB to bytes
  access_key = yandex_iam_service_account_static_access_key.this.access_key
  secret_key = yandex_iam_service_account_static_access_key.this.secret_key

  versioning {
    enabled = true
  }

  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        kms_master_key_id = yandex_kms_symmetric_key.this.id
        sse_algorithm     = "aws:kms"
      }
    }
  }

  lifecycle {
    prevent_destroy = true
  }
}
