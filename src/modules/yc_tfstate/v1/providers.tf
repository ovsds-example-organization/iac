terraform {
  required_version = ">= 1.4.0"

  required_providers {
    yandex = {
      source  = "yandex-cloud/yandex"
      version = "~> 0.112.0"
    }
  }
}

provider "yandex" {
  cloud_id = var.yc_cloud_id
  token    = var.yc_iam_token
}
