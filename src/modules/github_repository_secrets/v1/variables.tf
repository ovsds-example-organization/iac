variable "github_token" {
  type        = string
  description = "GitHub token to use in provider"
}

variable "organization_name" {
  type        = string
  description = "GitHub repository organization name"
}

variable "repository_name" {
  type        = string
  description = "GitHub repository name"
}

variable "secrets" {
  type        = map(string)
  description = "GitHub repository secrets"
}


