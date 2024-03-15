variable "github_organization_name" {
  type        = string
  description = "GitHub organization name"
}

variable "github_admin_token" {
  type        = string
  description = "GitHub admin token"
}

variable "github_robot_secrets" {
  type        = map(string)
  description = "GitHub robot secrets"
}
