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
