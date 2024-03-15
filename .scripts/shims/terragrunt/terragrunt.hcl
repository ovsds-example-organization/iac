terraform_binary = "${get_terragrunt_dir()}/../terraform/bin/terraform"
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
      "untaint"
    ]

    env_vars = {
      TF_CLI_CONFIG_FILE = "${get_terragrunt_dir()}/../terraform/terraform.hcl"
    }
  }
}

