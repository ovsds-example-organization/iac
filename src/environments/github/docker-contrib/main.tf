locals {
  repository_name = "docker-contrib"
}

module "repository" {
  source = "../../../modules/github_repository/v1"

  github_token      = var.github_admin_token
  organization_name = var.github_organization_name
  name              = local.repository_name
  is_public         = true

  master_branch_protection               = true
  master_branch_protection_status_checks = ["check-pr"]
}

module "secrets" {
  source = "../../../modules/github_repository_secrets/v1"

  github_token      = var.github_admin_token
  organization_name = var.github_organization_name
  repository_name   = local.repository_name

  secrets = {
    ROBOT_GITHUB_USER : var.github_robot_secrets["USER"]
    ROBOT_GITHUB_READ_PACKAGES_TOKEN : var.github_robot_secrets["READ_PACKAGES_TOKEN"]
    ROBOT_GITHUB_WRITE_PACKAGES_TOKEN : var.github_robot_secrets["WRITE_PACKAGES_TOKEN"]
  }
}
