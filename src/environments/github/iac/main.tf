locals {
  repository_name = "iac"
}

module "repository" {
  source = "../../../modules/github_repository/v1"

  github_token      = var.github_admin_token
  organization_name = var.github_organization_name
  name              = local.repository_name
}

module "robot" {
  source = "../../../modules/yc_ci_sa/v1"

  iam_token       = var.yc_iam_token
  cloud_id        = var.yc_cloud_id
  folder_id       = var.yc_folder_id
  repository_name = local.repository_name

  cloud_iam_members = { (var.yc_cloud_id) = "admin" }
}

module "secrets" {
  source = "../../../modules/github_repository_secrets/v1"

  github_token      = var.github_admin_token
  organization_name = var.github_organization_name
  repository_name   = local.repository_name

  secrets = {
    ROBOT_GITHUB_USER : var.github_robot_secrets["USER"]
    ROBOT_GITHUB_READ_PACKAGES_TOKEN : var.github_robot_secrets["READ_PACKAGES_TOKEN"]
    ROBOT_GITHUB_WRITE_PACKAGES_TOKEN : var.github_robot_secrets["ADMIN_TOKEN"]

    TFSTATE_ACCESS_KEY_ID : var.tfstate_secrets["ACCESS_KEY_ID"]
    TFSTATE_SECRET_ACCESS_KEY : var.tfstate_secrets["SECRET_ACCESS_KEY"]

    YC_KEY_ID : module.robot.key_id
    YC_SERVICE_ACCOUNT_ID : module.robot.service_account.id
    YC_PRIVATE_KEY : module.robot.private_key
  }
}
