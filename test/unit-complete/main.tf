module "test-sa" {
  source = "github.com/mineiros-io/terraform-google-service-account?ref=v0.0.10"

  account_id = "service-account-id-${local.random_suffix}"
}

module "test" {
  source = "../.."

  module_enabled = true

  # add all required arguments
  repository_id = "unit-complete"
  format        = "NPM"
  location      = "europe-west3"

  # add all optional arguments that create additional resources
  iam = [
    ### authoritative tests
    # when authoritative is true we do not need computed map
    {
      role = "roles/dummyRole0"
      members = [
        "computed:myserviceaccount",
      ]
      authoritative = true
    },
    {
      roles = [
        "roles/dummyRole0.1",
        "roles/dummyRole0.2",
      ]
      members = [
        "computed:myserviceaccount",
      ]
      authoritative = true
    },
    {
      role = "roles/dummyRole1"
      members = [
        "computed:myserviceaccount",
      ]
      authoritative = true
    },
    {
      roles = [
        "roles/dummyRole1.1",
        "roles/dummyRole1.2",
      ]
      members = [
        "computed:myserviceaccount",
      ]
      authoritative = true
    },

    ### authoritative tests
    # default
    {
      role = "roles/dummyRole2"
      members = [
        "computed:myserviceaccount",
      ]
    },
    {
      roles = [
        "roles/dummyRole2.0",
        "roles/dummyRole2.1",
      ]
      members = [
        "computed:myserviceaccount",
      ]
    },
    {
      role = "roles/dummyRole3"
      members = [
        "computed:myserviceaccount",
      ]
    },
    {
      roles = [
        "roles/dummyRole3.1",
        "roles/dummyRole3.2",
      ]
      members = [
        "computed:myserviceaccount",
      ]
    },

    ### non authoritative tests
    {
      role = "roles/dummyRole4"
      members = [
        "computed:myserviceaccount",
      ]
      authoritative = false
    },
    {
      roles = [
        "roles/dummyRole4.1",
        "roles/dummyRole4.2",
      ]
      members = [
        "computed:myserviceaccount",
      ]
      authoritative = false
    },
    {
      role = "roles/dummyRole5"
      members = [
        "computed:myserviceaccount",
      ]
      authoritative = false
    },
    {
      roles = [
        "roles/dummyRole5.1",
        "roles/dummyRole5.2",
      ]
      members = [
        "computed:myserviceaccount",
      ]
      authoritative = false
    }
  ]

  computed_members_map = {
    myserviceaccount = "serviceAccount:${module.test-sa.service_account.email}"
  }

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

module "test2" {
  source = "../.."

  module_enabled = true

  repository_id = "unit-complete-2-${local.random_suffix}"
  format        = "NPM"
  location      = "europe-west3"

  policy_bindings = [
    {
      role = "roles/artifactregistry.reader"
      members = [
        "user:member@example.com",
        "computed:myserviceaccount",
      ]
    },
    {
      role = "roles/artifactregistry.writer"
      members = [
        "user:member@example.com",
      ]
    }
  ]

  computed_members_map = {
    myserviceaccount = "serviceAccount:${module.test-sa.service_account.email}"
  }

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
