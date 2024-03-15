variable "iam_token" {
  type        = string
  description = "IAM token"
}

variable "cloud_id" {
  type        = string
  description = "YC Cloud id to create resources in"
}

variable "folder_id" {
  type        = string
  description = "YC Folder id to create resources in"
}

variable "repository_name" {
  type        = string
  description = "Name of the repository to create service account for"
}

variable "cloud_iam_members" {
  type        = map(string)
  description = "IAM bindings map to apply to the service account, format: {cloud_id = role}"
  default     = {}
}
