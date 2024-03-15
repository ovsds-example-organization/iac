locals {
  github_robot_secrets = data.yandex_lockbox_secret_version.github_robot.entries != null ? {
    for secret in data.yandex_lockbox_secret_version.github_robot.entries :
    secret.key => secret.text_value
  } : {}
}

resource "yandex_resourcemanager_folder" "this" {
  cloud_id = var.yc_cloud_id

  name        = "github"
  description = "Folder for GitHub related resources"
}

resource "yandex_lockbox_secret" "github_robot" {
  folder_id = yandex_resourcemanager_folder.this.id

  name        = "github_robot"
  description = "GitHub robot tokens, provided manually"
}

data "yandex_lockbox_secret_version" "github_robot" {
  secret_id = yandex_lockbox_secret.github_robot.id
}
