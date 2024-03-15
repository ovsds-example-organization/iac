# ovsds-example-organization/iac

Infrastructure code representation for ovsds example organization.

## Development

### Global dependencies

- [node](https://github.com/ovsds-personal/wiki/blob/master/src/global_dependencies/nvm/README.md)
- [yacloud-cli](https://github.com/ovsds-personal/wiki/blob/master/src/global_dependencies/yacloud-cli/README.md)

### Environment

To activate the environment, run:

```shell
source .scripts/bash/environment_activate
```

### Taskfile commands

For all commands see [Taskfile](Taskfile.yaml) or `task --list-all`.

### HOWTO new cloud

As soon as we are using same cloud for our tfstate we need some special steps to create new cloud.

1. Create new cloud in YaCloud console.
2. Create profile for new cloud in YaCloud CLI with `yc init` command.
3. Set profile name in `.scripts/secrets/.env` file. Check `.env.example` for example.
   This variable will be used for environment_activate script to set correct profile for YaCloud CLI.
4. Set your yc_cloud_id in `src/environments/tfstate/environment.tfvars` file.

Before running any terraform commands for the first time we need to create terraform state bucket.
Resources described in `src/enviroments/tfstate/000_tfstate`, but terraform backend is already configured for
yet not created bucket. So we need to create it first with local state.

```shell
task terragrunt DIR=./src/environments/tfstate/000_tfstate CONFIG=terragrunt_local.hcl -- init
source .scripts/secrets/.env && \
    TF_VAR_yc_iam_token=$(yc iam create-token --profile $YC_PROFILE) \
    task terragrunt DIR=./src/environments/tfstate/000_tfstate CONFIG=terragrunt_local.hcl -- apply
```

Now, since all required secrets are created, we activate environment and migrate state to remote:

```shell
source .scripts/bash/environment_activate
task terragrunt DIR=./src/environments/tfstate/000_tfstate -- init -migrate-state
```

Don't forget to remove local state.

```shell
rm -f ./src/environments/tfstate/000_tfstate/*.tfstate.*
```

Done. Now you can use regular flow for terraform commands.
