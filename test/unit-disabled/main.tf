module "test" {
  source = "../.."

  module_enabled = false

  # add all required arguments
  repository_id = "unit-disabled"

  # add all optional arguments that create additional resources
  iam = [
    {
      role    = "roles/iam.serviceAccountUser"
      members = ["serviceAccount:noneexiting"]
    }
  ]
}
