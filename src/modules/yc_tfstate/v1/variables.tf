variable "yc_iam_token" {
  type        = string
  description = "IAM token"
}

variable "yc_cloud_id" {
  type        = string
  description = "YC Cloud id to create tf state resources in"
}

variable "yc_folder_name" {
  type        = string
  description = "YC Folder name to create tf state resources in"
  default     = "tfstate"
}

variable "bucket_name" {
  type        = string
  description = "Object storage bucket name"
}

variable "bucket_max_size" {
  type        = number
  description = "Object storage bucket max size in MB"
  default     = 1024
}

variable "service_account_name" {
  type        = string
  description = "tfstate Service account name"
  default     = "tfstate-sa"
}

variable "lockbox_name" {
  type        = string
  description = "Lockbox name"
  default     = "tfstate_bucket_keys"
}
