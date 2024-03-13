variable "github_organization_name" {
  type        = string
  description = "GitHub organization"
}

variable "github_admin_token" {
  type        = string
  description = "GitHub organization admin token"
}

variable "github_robot_secrets" {
  type        = map(string)
  description = "GitHub robot secrets"
}

variable "tfstate_secrets" {
  type        = map(string)
  description = "Secrets to tfstate bucket"
}

variable "yc_iam_token" {
  type        = string
  description = "Yandex Cloud IAM token"
}

variable "yc_cloud_id" {
  type        = string
  description = "Yandex Cloud ID"
}

variable "yc_folder_id" {
  type        = string
  description = "Yandex Cloud folder ID"
}
