header {
  image = "https://raw.githubusercontent.com/mineiros-io/brand/3bffd30e8bdbbde32c143e2650b2faa55f1df3ea/mineiros-primary-logo.svg"
  url   = "https://mineiros.io/?ref=terraform-google-artifact-registry-repository"

  badge "build" {
    image = "https://github.com/mineiros-io/terraform-google-artifact-registry-repository/workflows/Tests/badge.svg"
    url   = "https://github.com/mineiros-io/terraform-google-artifact-registry-repository/actions"
    text  = "Build Status"
  }

  badge "semver" {
    image = "https://img.shields.io/github/v/tag/mineiros-io/terraform-google-artifact-registry-repository.svg?label=latest&sort=semver"
    url   = "https://github.com/mineiros-io/terraform-google-artifact-registry-repository/releases"
    text  = "GitHub tag (latest SemVer)"
  }

  badge "terraform" {
    image = "https://img.shields.io/badge/Terraform-1.x-623CE4.svg?logo=terraform"
    url   = "https://github.com/hashicorp/terraform/releases"
    text  = "Terraform Version"
  }

  badge "tf-gcp-provider" {
    image = "https://img.shields.io/badge/google-4-1A73E8.svg?logo=terraform"
    url   = "https://github.com/terraform-providers/terraform-provider-google/releases"
    text  = "Google Provider Version"
  }

  badge "slack" {
    image = "https://img.shields.io/badge/slack-@mineiros--community-f32752.svg?logo=slack"
    url   = "https://mineiros.io/slack"
    text  = "Join Slack"
  }
}

section {
  title   = "terraform-google-artifact-registry-repository"
  toc     = true
  content = <<-END
    A [Terraform] module for [Google Cloud Platform (GCP)][gcp].

    **_This module supports Terraform version 1
    and is compatible with the Terraform Google Provider version 5.14._**

    This module is part of our Infrastructure as Code (IaC) framework
    that enables our users and customers to easily deploy and manage reusable,
    secure, and production-grade cloud infrastructure.

    As the evolution of [Google Container Registry (GCR)](https://cloud.google.com/container-registry),
    [Artifact Registry](https://cloud.google.com/artifact-registry) is a single place for your organization to manage
    container images and language packages (such as Maven and npm).

    It is fully integrated with Google Cloud’s tooling and runtimes and comes with support for native artifact protocols.
    This makes it simple to integrate with your CI/CD tooling to set up automated pipelines.

    Contrary to GCR, Artifact Registry doesn’t have the concept of a single registry that you can use to push multiple
    images or packages to. It rather allows you to
    [create repositories with a single purpose](https://cloud.google.com/artifact-registry/docs/manage-repos) (single-responsibility),
    e.g. a repository that stores Docker images, a repository that stores npm images, etc.

    For getting an overview of the available formats, please see https://cloud.google.com/artifact-registry/docs/supported-formats.
  END

  section {
    title   = "Module Features"
    content = <<-END
      This module implements the following Terraform resources

      - `google_artifact_registry_repository`

      and supports additional features of the following modules:

      - [mineiros-io/terraform-google-artifact-registry-repository-iam](https://github.com/mineiros-io/terraform-google-artifact-registry-repository-iam)
    END
  }

  section {
    title   = "Getting Started"
    content = <<-END
      Most basic usage just setting required arguments:

      ```hcl
      module "terraform-google-artifact-registry-repository" {
        source = "github.com/mineiros-io/terraform-google-artifact-registry-repository?ref=v0.0.3"

        repository_id = "my-repository"
      }
      ```
    END
  }

  section {
    title   = "Module Argument Reference"
    content = <<-END
      See [variables.tf] and [examples/] for details and use-cases.
    END

    section {
      title = "Top-level Arguments"

      section {
        title = "Module Configuration"

        variable "module_enabled" {
          type        = bool
          default     = true
          description = <<-END
            Specifies whether resources in the module will be created.
          END
        }

        variable "module_timeouts" {
          type           = map(timeout)
          description    = <<-END
            A map of timeout objects that is keyed by Terraform resource name
            defining timeouts for `create`, `update` and `delete` Terraform operations.
            Supported resource names are: `google_artifact_registry_repository`.
          END
          readme_example = <<-END
            module_timeouts = {
              google_artifact_registry_repository = {
                create = "4m"
                update = "4m"
                delete = "4m"
              }
            }
          END

          attribute "create" {
            type        = string
            description = <<-END
              Timeout for create operations.
            END
          }

          attribute "update" {
            type        = string
            description = <<-END
              Timeout for update operations.
            END
          }

          attribute "delete" {
            type        = string
            description = <<-END
              Timeout for delete operations.
            END
          }
        }

        variable "module_depends_on" {
          type           = list(dependency)
          description    = <<-END
            A list of dependencies.
            Any object can be _assigned_ to this list to define a hidden external dependency.
          END
          default        = []
          readme_example = <<-END
            module_depends_on = [
              null_resource.name
            ]
          END
        }
      }

      section {
        title = "Main Resource Configuration"

        variable "repository_id" {
          required    = true
          type        = string
          description = <<-END
            The last part of the repository name, for example: `repo1`.
          END
        }

        variable "location" {
          type        = string
          description = <<-END
            The name of the location this repository is located in. If it is not provided, the provider location is used.
          END
        }

        variable "format" {
          type        = string
          default     = "DOCKER"
          description = <<-END
            The format of packages that are stored in the repository. You can only create alpha formats if you are a member of the alpha user group. Possible values are `DOCKER`, `MAVEN`, `NPM`, `PYTHON`, `APT` (alpha), `YUM` (alpha).
          END
        }

        variable "description" {
          type        = string
          description = <<-END
            The user-provided description of the repository.
          END
        }

        variable "labels" {
          type        = map(string)
          description = <<-END
            Labels with user-defined metadata. This field may contain up to 64 entries. Label keys and values may be no longer than 63 characters. Label keys must begin with a lowercase letter and may only contain lowercase letters, numeric characters, underscores, and dashes.
          END
        }

        variable "kms_key_name" {
          type        = string
          description = <<-END
            The Cloud KMS resource name of the customer managed encryption key that's used to encrypt the contents of the Repository. Has the form: `projects/my-project/locations/my-region/keyRings/my-kr/cryptoKeys/my-key`. This value may not be changed after the Repository has been created.
          END
        }

        variable "project" {
          type        = string
          description = <<-END
            The ID of the project in which the resource belongs. If it is not provided, the provider project is used.
          END
        }

        variable "cleanup_policy_dry_run" {
          type        = bool
          description = <<-END
            If true, the cleanup pipeline is prevented from deleting versions in this repository.
          END
        }

        variable "cleanup_policies" {
          type        = any
          description = <<-END
            Cleanup policies for this repository.
          END

          attribute "id" {
            type        = string
            description = <<-END
            (Required) The identifier for this object. Format specified above.
          END
          }

          attribute "action" {
            type        = string
            description = <<-END
            (Optional) Policy action. Possible values are: DELETE, KEEP.
          END
          }

          attribute "condition" {
            type        = number
            description = <<-END
            (Optional) Policy condition for matching versions.
          END

            attribute "tag_state" {
              type        = string
              default     = "ANY"
              description = <<-END
            (Optional) Match versions by tag status.
            Possible values are: TAGGED, UNTAGGED, ANY.
          END
            }

            attribute "tag_prefixes" {
              type        = string
              description = <<-END
            (Optional) Match versions by tag prefix. Applied on any prefix match.
          END
            }

            attribute "version_name_prefixes" {
              type        = string
              description = <<-END
            (Optional) Match versions by version name prefix. Applied on any prefix match.
          END
            }

            attribute "package_name_prefixes" {
              type        = string
              description = <<-END
            (Optional) Match versions by package prefix. Applied on any prefix match.
          END
            }

            attribute "older_than" {
              type        = string
              description = <<-END
            (Optional) Match versions older than a duration.
          END
            }

            attribute "newer_than" {
              type        = string
              description = <<-END
            (Optional) Match versions newer than a duration.
          END
            }
          }

          attribute "most_recent_versions" {
            type        = number
            description = <<-END
            (Optional) Policy condition for retaining a minimum number of versions. 
            May only be specified with a Keep action.
          END

            attribute "package_name_prefixes" {
              type        = string
              description = <<-END
            (Optional) Match versions by package prefix. Applied on any prefix match.
          END
            }

            attribute "keep_count" {
              type        = string
              description = <<-END
            (Optional) Minimum number of versions to keep.
          END
            }
          }
        }
      }

      section {
        title = "Extended Resource Configuration"

        variable "iam" {
          type           = list(iam)
          default        = []
          description    = <<-END
            A list of IAM access.
          END
          readme_example = <<-END
            iam = [{
              role = "roles/artifactregistry.writer"
              members = ["user:member@example.com"]
              authoritative = false
            }]
          END

          attribute "members" {
            type        = set(string)
            default     = []
            description = <<-END
              Identities that will be granted the privilege in role. Each entry can have one of the following values:
              - `allUsers`: A special identifier that represents anyone who is on the internet; with or without a Google account.
              - `allAuthenticatedUsers`: A special identifier that represents anyone who is authenticated with a Google account or a service account.
              - `user:{emailid}`: An email address that represents a specific Google account. For example, alice@gmail.com or joe@example.com.
              - `serviceAccount:{emailid}`: An email address that represents a service account. For example, my-other-app@appspot.gserviceaccount.com.
              - `group:{emailid}`: An email address that represents a Google group. For example, admins@example.com.
              - `domain:{domain}`: A G Suite domain (primary, instead of alias) name that represents all the users of that domain. For example, google.com or example.com.
              - `projectOwner:projectid`: Owners of the given project. For example, `projectOwner:my-example-project`
              - `projectEditor:projectid`: Editors of the given project. For example, `projectEditor:my-example-project`
              - `projectViewer:projectid`: Viewers of the given project. For example, `projectViewer:my-example-project`
              - `computed:{identifier}`: An existing key from `var.computed_members_map`.
            END
          }

          attribute "role" {
            type        = string
            description = <<-END
              The role that should be applied. Note that custom roles must be of the format `[projects|organizations]/{parent-name}/roles/{role-name}`.
            END
          }

          attribute "roles" {
            type        = list(string)
            description = <<-END
              The set of roles that should be applied. Note that custom roles must be of the format `[projects|organizations]/{parent-name}/roles/{role-name}`.
            END
          }

          attribute "authoritative" {
            type        = bool
            default     = true
            description = <<-END
              Whether to exclusively set (authoritative mode) or add (non-authoritative/additive mode) members to the role.
            END
          }

          attribute "condition" {
            type           = object(condition)
            description    = <<-END
              An IAM Condition for a given binding.
            END
            readme_example = <<-END
              condition = {
                expression = "request.time < timestamp(\"2022-01-01T00:00:00Z\")"
                title      = "expires_after_2021_12_31"
              }
            END
          }
        }

        variable "computed_members_map" {
          type        = map(string)
          description = <<-END
            A map of members to replace in `members` of various IAM settings to handle terraform computed values.
          END
          default     = {}
        }

        variable "policy_bindings" {
          type           = list(policy_bindings)
          description    = <<-END
            A list of IAM policy bindings.
          END
          readme_example = <<-END
            policy_bindings = [{
              role    = "roles/artifactregistry.writer"
              members = ["user:member@example.com"]
              condition = {
                title       = "expires_after_2021_12_31"
                description = "Expiring at midnight of 2021-12-31"
                expression  = "request.time < timestamp(\"2022-01-01T00:00:00Z\")"
              }
            }]
          END

          attribute "role" {
            required    = true
            type        = string
            description = <<-END
              The role that should be applied.
            END
          }

          attribute "members" {
            type        = set(string)
            default     = var.members
            description = <<-END
              Identities that will be granted the privilege in `role`.
            END
          }

          attribute "condition" {
            type           = object(condition)
            description    = <<-END
              An IAM Condition for a given binding.
            END
            readme_example = <<-END
              condition = {
                expression = "request.time < timestamp(\"2022-01-01T00:00:00Z\")"
                title      = "expires_after_2021_12_31"
              }
            END

            attribute "expression" {
              required    = true
              type        = string
              description = <<-END
                Textual representation of an expression in Common Expression Language syntax.
              END
            }

            attribute "title" {
              required    = true
              type        = string
              description = <<-END
                A title for the expression, i.e. a short string describing its purpose.
              END
            }

            attribute "description" {
              type        = string
              description = <<-END
                An optional description of the expression. This is a longer text which describes the expression, e.g. when hovered over it in a UI.
              END
            }
          }
        }
      }
    }
  }

  section {
    title   = "Module Outputs"
    content = <<-END
      The following attributes are exported in the outputs of the module:
    END

    output "repository" {
      type        = object(repository)
      description = <<-END
        All `google_artifact_registry_repository` resource attributes.
      END
    }

    output "iam" {
      type        = list(iam)
      description = <<-END
        The `iam` resource objects that define the access to the resources.
      END
    }

    output "policy_binding" {
      type        = object(policy_binding)
      description = <<-END
        All attributes of the created policy_bindings `mineiros-io/terraform-google-artifact-registry-repository-iam/google` module when using policy bindings.
      END
    }
  }

  section {
    title = "External Documentation"

    section {
      title   = "Google Documentation"
      content = <<-END
        - https://cloud.google.com/artifact-registry
      END
    }

    section {
      title   = "Terraform Google Provider Documentation:"
      content = <<-END
        - https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/artifact_registry_repository
        - https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/artifact_registry_repository_iam

      END
    }
  }

  section {
    title   = "Module Versioning"
    content = <<-END
      This Module follows the principles of [Semantic Versioning (SemVer)].

      Given a version number `MAJOR.MINOR.PATCH`, we increment the:

      1. `MAJOR` version when we make incompatible changes,
      2. `MINOR` version when we add functionality in a backwards compatible manner, and
      3. `PATCH` version when we make backwards compatible bug fixes.
    END

    section {
      title   = "Backwards compatibility in `0.0.z` and `0.y.z` version"
      content = <<-END
        - Backwards compatibility in versions `0.0.z` is **not guaranteed** when `z` is increased. (Initial development)
        - Backwards compatibility in versions `0.y.z` is **not guaranteed** when `y` is increased. (Pre-release)
      END
    }
  }

  section {
    title   = "About Mineiros"
    content = <<-END
      [Mineiros][homepage] is a remote-first company headquartered in Berlin, Germany
      that solves development, automation and security challenges in cloud infrastructure.

      Our vision is to massively reduce time and overhead for teams to manage and
      deploy production-grade and secure cloud infrastructure.

      We offer commercial support for all of our modules and encourage you to reach out
      if you have any questions or need help. Feel free to email us at [hello@mineiros.io] or join our
      [Community Slack channel][slack].
    END
  }

  section {
    title   = "Reporting Issues"
    content = <<-END
      We use GitHub [Issues] to track community reported issues and missing features.
    END
  }

  section {
    title   = "Contributing"
    content = <<-END
      Contributions are always encouraged and welcome! For the process of accepting changes, we use
      [Pull Requests]. If you'd like more information, please see our [Contribution Guidelines].
    END
  }

  section {
    title   = "Makefile Targets"
    content = <<-END
      This repository comes with a handy [Makefile].
      Run `make help` to see details on each available target.
    END
  }

  section {
    title   = "License"
    content = <<-END
      [![license][badge-license]][apache20]

      This module is licensed under the Apache License Version 2.0, January 2004.
      Please see [LICENSE] for full details.

      Copyright &copy; 2020-2022 [Mineiros GmbH][homepage]
    END
  }
}

references {
  ref "homepage" {
    value = "https://mineiros.io/?ref=terraform-google-artifact-registry-repository"
  }
  ref "hello@mineiros.io" {
    value = "mailto:hello@mineiros.io"
  }
  ref "badge-build" {
    value = "https://github.com/mineiros-io/terraform-google-artifact-registry-repository/workflows/Tests/badge.svg"
  }
  ref "badge-semver" {
    value = "https://img.shields.io/github/v/tag/mineiros-io/terraform-google-artifact-registry-repository.svg?label=latest&sort=semver"
  }
  ref "badge-license" {
    value = "https://img.shields.io/badge/license-Apache%202.0-brightgreen.svg"
  }
  ref "badge-terraform" {
    value = "https://img.shields.io/badge/Terraform-1.x-623CE4.svg?logo=terraform"
  }
  ref "badge-slack" {
    value = "https://img.shields.io/badge/slack-@mineiros--community-f32752.svg?logo=slack"
  }
  ref "build-status" {
    value = "https://github.com/mineiros-io/terraform-google-artifact-registry-repository/actions"
  }
  ref "releases-github" {
    value = "https://github.com/mineiros-io/terraform-google-artifact-registry-repository/releases"
  }
  ref "releases-terraform" {
    value = "https://github.com/hashicorp/terraform/releases"
  }
  ref "badge-tf-gcp" {
    value = "https://img.shields.io/badge/google-3.x-1A73E8.svg?logo=terraform"
  }
  ref "releases-google-provider" {
    value = "https://github.com/terraform-providers/terraform-provider-google/releases"
  }
  ref "apache20" {
    value = "https://opensource.org/licenses/Apache-2.0"
  }
  ref "slack" {
    value = "https://mineiros.io/slack"
  }
  ref "terraform" {
    value = "https://www.terraform.io"
  }
  ref "gcp" {
    value = "https://cloud.google.com/"
  }
  ref "semantic versioning (semver)" {
    value = "https://semver.org/"
  }
  ref "variables.tf" {
    value = "https://github.com/mineiros-io/terraform-google-artifact-registry-repository/blob/main/variables.tf"
  }
  ref "examples/" {
    value = "https://github.com/mineiros-io/terraform-google-artifact-registry-repository/blob/main/examples"
  }
  ref "issues" {
    value = "https://github.com/mineiros-io/terraform-google-artifact-registry-repository/issues"
  }
  ref "license" {
    value = "https://github.com/mineiros-io/terraform-google-artifact-registry-repository/blob/main/LICENSE"
  }
  ref "makefile" {
    value = "https://github.com/mineiros-io/terraform-google-artifact-registry-repository/blob/main/Makefile"
  }
  ref "pull requests" {
    value = "https://github.com/mineiros-io/terraform-google-artifact-registry-repository/pulls"
  }
  ref "contribution guidelines" {
    value = "https://github.com/mineiros-io/terraform-google-artifact-registry-repository/blob/main/CONTRIBUTING.md"
  }
}
