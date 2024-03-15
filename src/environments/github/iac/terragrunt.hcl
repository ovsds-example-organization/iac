include "root" {
  path   = find_in_parent_folders()
}

dependency "yc_folder" {
  config_path = "../000_yc_folder"
}

dependency "tfstate" {
  config_path = "../../tfstate/000_tfstate"
}

inputs = {
  yc_folder_id = dependency.yc_folder.outputs.yc_folder_id
  github_admin_token = dependency.yc_folder.outputs.github_robot_admin_token
  github_robot_secrets = dependency.yc_folder.outputs.github_robot_secrets
  tfstate_secrets = dependency.tfstate.outputs.tfstate_secrets
}
