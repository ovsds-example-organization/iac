variable "iam_token" {
  type        = string
  description = "IAM token"
}

variable "cloud_id" {
  type        = string
  description = "YC Cloud id to create tf state resources in"
}

variable "bucket_name" {
  type        = string
  description = "Object storage bucket name"
}
