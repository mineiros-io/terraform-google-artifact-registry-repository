globals {
  minimum_terraform_version = "1.0"

  minimum_provider_version = "5.14"
  provider                 = "google-beta"

  provider_version_constraint  = ">= ${global.minimum_provider_version}, <6"
  terraform_version_constraint = "~> ${global.minimum_terraform_version}, != 1.1.0, != 1.1.1"
  # we exclude 1.1.0 and 1.1.1 because of:
  # https://github.com/hashicorp/terraform/blob/v1.1/CHANGELOG.md#112-december-17-2021
}
