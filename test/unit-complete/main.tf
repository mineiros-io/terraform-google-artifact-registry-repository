module "test" {
  source = "../.."

  module_enabled = true

  # add all required arguments
  repository_id = "unit-complete"
  format        = "NPM"
  location      = "europe-west3"

  # add all optional arguments that create additional resources
  iam = [
    {
      role    = "roles/artifactregistry.writer"
      members = ["serviceAccount:github-terraform-tests@terraform-service-catalog.iam.gserviceaccount.com"]
    }
  ]

  # add most/all other optional arguments
  description = "An artifact registry created by an automated unit-test in https://github.com/mineiros-io/terraform-google-artifact-registry-repository."

  labels = {
    env = "prod"
  }

  project = var.gcp_project

  module_timeouts = {
    google_artifact_registry_repository = {
      create = "10m"
      update = "10m"
      delete = "10m"
    }
  }

  module_depends_on = ["nothing"]
}

