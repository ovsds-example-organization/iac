terraform_binary = "${get_parent_terragrunt_dir()}/../.scripts/shims/terraform/bin/terraform"
download_dir = "~/.terragrunt.d/plugin-cache"

terraform {
  extra_arguments "tf_cli_config" {
    commands = [
      "init",
      "plan",
      "apply",
      "refresh",
      "import",
      "taint",
      "untaint",
    ]

    env_vars = {
      TF_CLI_CONFIG_FILE = "${get_parent_terragrunt_dir()}/../.scripts/shims/terraform/terraform.hcl"
    }
  }

  extra_arguments "var_files" {
    commands = [
      "apply",
      "plan",
      "import",
      "push",
      "refresh",
    ]

    optional_var_files = [
      "${find_in_parent_folders("environment.tfvars", "skip-env-if-does-not-exist")}",
      "${find_in_parent_folders("layer.tfvars", "skip-env-if-does-not-exist")}",
    ]
  }
}

remote_state {
  backend = "s3"
  generate = {
    path      = "backend.tf"
    if_exists = "overwrite"
  }
  config = {
    endpoint = "https://storage.yandexcloud.net"
    bucket   = "ovsds-example-cloud-tfstate"
    region   = "ru-central1"
    key      = "${path_relative_to_include()}/terraform.tfstate"

    skip_region_validation      = true
    skip_credentials_validation = true
    skip_requesting_account_id  = true
    skip_s3_checksum            = true

    disable_bucket_update = true
  }
}
