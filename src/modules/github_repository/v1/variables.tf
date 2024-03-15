variable "github_token" {
  type        = string
  description = "GitHub token to use in provider"
}

variable "organization_name" {
  type        = string
  description = "Organization to create the repository in"
}

variable "name" {
  type        = string
  description = "Name of the repository"
}

variable "master_branch_name" {
  type        = string
  default     = "main"
  description = "Name of the master branch"
}

variable "is_public" {
  type        = bool
  default     = false
  description = "Whether the repository is public"
}

variable "master_branch_protection" {
  type        = bool
  default     = false
  description = "Whether the master branch is protected"
}

variable "master_branch_protection_status_checks" {
  type        = list(string)
  default     = []
  description = "Status checks for the master branch protection"
}
