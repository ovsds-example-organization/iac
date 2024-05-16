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

variable "tfstate_yc_folder_id" {
  type        = string
  description = "tfstate Yandex Cloud folder ID"
}

variable "tfstate_access_key_id" {
  type        = string
  description = "tfstate Access key ID"
}

variable "tfstate_secret_access_key" {
  type        = string
  description = "tfstate Secret access key"
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
