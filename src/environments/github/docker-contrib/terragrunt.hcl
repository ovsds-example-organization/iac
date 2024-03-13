include "root" {
  path   = find_in_parent_folders()
}

dependency "yc_folder" {
  config_path = "../000_yc_folder"
}

inputs = {
  github_admin_token = dependency.yc_folder.outputs.github_robot_admin_token
  github_robot_secrets = dependency.yc_folder.outputs.github_robot_secrets
}
