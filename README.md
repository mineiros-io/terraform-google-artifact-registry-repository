[<img src="https://raw.githubusercontent.com/mineiros-io/brand/3bffd30e8bdbbde32c143e2650b2faa55f1df3ea/mineiros-primary-logo.svg" width="400"/>](https://mineiros.io/?ref=terraform-google-artifact-registry-repository)

[![Build Status](https://github.com/mineiros-io/terraform-google-artifact-registry-repository/workflows/Tests/badge.svg)](https://github.com/mineiros-io/terraform-google-artifact-registry-repository/actions)
[![GitHub tag (latest SemVer)](https://img.shields.io/github/v/tag/mineiros-io/terraform-google-artifact-registry-repository.svg?label=latest&sort=semver)](https://github.com/mineiros-io/terraform-google-artifact-registry-repository/releases)
[![Terraform Version](https://img.shields.io/badge/Terraform-1.x-623CE4.svg?logo=terraform)](https://github.com/hashicorp/terraform/releases)
[![Google Provider Version](https://img.shields.io/badge/google-4-1A73E8.svg?logo=terraform)](https://github.com/terraform-providers/terraform-provider-google/releases)
[![Join Slack](https://img.shields.io/badge/slack-@mineiros--community-f32752.svg?logo=slack)](https://mineiros.io/slack)

# terraform-google-artifact-registry-repository

A [Terraform] module for [Google Cloud Platform (GCP)][gcp].

**_This module supports Terraform version 1
and is compatible with the Terraform Google Provider version 4._**

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


- [Module Features](#module-features)
- [Getting Started](#getting-started)
- [Module Argument Reference](#module-argument-reference)
  - [Top-level Arguments](#top-level-arguments)
    - [Module Configuration](#module-configuration)
    - [Main Resource Configuration](#main-resource-configuration)
    - [Extended Resource Configuration](#extended-resource-configuration)
- [Module Outputs](#module-outputs)
- [External Documentation](#external-documentation)
  - [Google Documentation](#google-documentation)
  - [Terraform Google Provider Documentation:](#terraform-google-provider-documentation)
- [Module Versioning](#module-versioning)
  - [Backwards compatibility in `0.0.z` and `0.y.z` version](#backwards-compatibility-in-00z-and-0yz-version)
- [About Mineiros](#about-mineiros)
- [Reporting Issues](#reporting-issues)
- [Contributing](#contributing)
- [Makefile Targets](#makefile-targets)
- [License](#license)

## Module Features

This module implements the following Terraform resources

- `google_artifact_registry_repository`

and supports additional features of the following modules:

- [mineiros-io/terraform-google-artifact-registry-repository-iam](https://github.com/mineiros-io/terraform-google-artifact-registry-repository-iam)

## Getting Started

Most basic usage just setting required arguments:

```hcl
module "terraform-google-artifact-registry-repository" {
  source = "github.com/mineiros-io/terraform-google-artifact-registry-repository?ref=v0.0.3"

  repository_id = "my-repository"
}
```

## Module Argument Reference

See [variables.tf] and [examples/] for details and use-cases.

### Top-level Arguments

#### Module Configuration

- [**`module_enabled`**](#var-module_enabled): *(Optional `bool`)*<a name="var-module_enabled"></a>

  Specifies whether resources in the module will be created.

  Default is `true`.

- [**`module_timeouts`**](#var-module_timeouts): *(Optional `map(timeout)`)*<a name="var-module_timeouts"></a>

  A map of timeout objects that is keyed by Terraform resource name
  defining timeouts for `create`, `update` and `delete` Terraform operations.
  Supported resource names are: `google_artifact_registry_repository`.

  Example:

  ```hcl
  module_timeouts = {
    google_artifact_registry_repository = {
      create = "4m"
      update = "4m"
      delete = "4m"
    }
  }
  ```

  Each `timeout` object in the map accepts the following attributes:

  - [**`create`**](#attr-module_timeouts-create): *(Optional `string`)*<a name="attr-module_timeouts-create"></a>

    Timeout for create operations.

  - [**`update`**](#attr-module_timeouts-update): *(Optional `string`)*<a name="attr-module_timeouts-update"></a>

    Timeout for update operations.

  - [**`delete`**](#attr-module_timeouts-delete): *(Optional `string`)*<a name="attr-module_timeouts-delete"></a>

    Timeout for delete operations.

- [**`module_depends_on`**](#var-module_depends_on): *(Optional `list(dependency)`)*<a name="var-module_depends_on"></a>

  A list of dependencies.
  Any object can be _assigned_ to this list to define a hidden external dependency.

  Default is `[]`.

  Example:

  ```hcl
  module_depends_on = [
    null_resource.name
  ]
  ```

#### Main Resource Configuration

- [**`repository_id`**](#var-repository_id): *(**Required** `string`)*<a name="var-repository_id"></a>

  The last part of the repository name, for example: `repo1`.

- [**`location`**](#var-location): *(Optional `string`)*<a name="var-location"></a>

  The name of the location this repository is located in. If it is not provided, the provider location is used.

- [**`format`**](#var-format): *(Optional `string`)*<a name="var-format"></a>

  The format of packages that are stored in the repository. You can only create alpha formats if you are a member of the alpha user group. Possible values are `DOCKER`, `MAVEN`, `NPM`, `PYTHON`, `APT` (alpha), `YUM` (alpha).

  Default is `"DOCKER"`.

- [**`description`**](#var-description): *(Optional `string`)*<a name="var-description"></a>

  The user-provided description of the repository.

- [**`labels`**](#var-labels): *(Optional `map(string)`)*<a name="var-labels"></a>

  Labels with user-defined metadata. This field may contain up to 64 entries. Label keys and values may be no longer than 63 characters. Label keys must begin with a lowercase letter and may only contain lowercase letters, numeric characters, underscores, and dashes.

- [**`kms_key_name`**](#var-kms_key_name): *(Optional `string`)*<a name="var-kms_key_name"></a>

  The Cloud KMS resource name of the customer managed encryption key that's used to encrypt the contents of the Repository. Has the form: `projects/my-project/locations/my-region/keyRings/my-kr/cryptoKeys/my-key`. This value may not be changed after the Repository has been created.

- [**`project`**](#var-project): *(Optional `string`)*<a name="var-project"></a>

  The ID of the project in which the resource belongs. If it is not provided, the provider project is used.

#### Extended Resource Configuration

- [**`iam`**](#var-iam): *(Optional `list(iam)`)*<a name="var-iam"></a>

  A list of IAM access.

  Default is `[]`.

  Example:

  ```hcl
  iam = [{
    role = "roles/secretmanager.admin"
    members = ["user:member@example.com"]
    authoritative = false
  }]
  ```

  Each `iam` object in the list accepts the following attributes:

  - [**`members`**](#attr-iam-members): *(Optional `set(string)`)*<a name="attr-iam-members"></a>

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

    Default is `[]`.

  - [**`role`**](#attr-iam-role): *(Optional `string`)*<a name="attr-iam-role"></a>

    The role that should be applied. Note that custom roles must be of the format `[projects|organizations]/{parent-name}/roles/{role-name}`.

  - [**`authoritative`**](#attr-iam-authoritative): *(Optional `bool`)*<a name="attr-iam-authoritative"></a>

    Whether to exclusively set (authoritative mode) or add (non-authoritative/additive mode) members to the role.

    Default is `true`.

- [**`policy_bindings`**](#var-policy_bindings): *(Optional `list(policy_bindings)`)*<a name="var-policy_bindings"></a>

  A list of IAM policy bindings.

  Example:

  ```hcl
  policy_bindings = [{
    role    = "roles/secretmanager.admin"
    members = ["user:member@example.com"]
    condition = {
      title       = "expires_after_2021_12_31"
      description = "Expiring at midnight of 2021-12-31"
      expression  = "request.time < timestamp(\"2022-01-01T00:00:00Z\")"
    }
  }]
  ```

  Each `policy_bindings` object in the list accepts the following attributes:

  - [**`role`**](#attr-policy_bindings-role): *(**Required** `string`)*<a name="attr-policy_bindings-role"></a>

    The role that should be applied.

  - [**`members`**](#attr-policy_bindings-members): *(Optional `set(string)`)*<a name="attr-policy_bindings-members"></a>

    Identities that will be granted the privilege in `role`.

    Default is `var.members`.

  - [**`condition`**](#attr-policy_bindings-condition): *(Optional `object(condition)`)*<a name="attr-policy_bindings-condition"></a>

    An IAM Condition for a given binding.

    Example:

    ```hcl
    condition = {
      expression = "request.time < timestamp(\"2022-01-01T00:00:00Z\")"
      title      = "expires_after_2021_12_31"
    }
    ```

    The `condition` object accepts the following attributes:

    - [**`expression`**](#attr-policy_bindings-condition-expression): *(**Required** `string`)*<a name="attr-policy_bindings-condition-expression"></a>

      Textual representation of an expression in Common Expression Language syntax.

    - [**`title`**](#attr-policy_bindings-condition-title): *(**Required** `string`)*<a name="attr-policy_bindings-condition-title"></a>

      A title for the expression, i.e. a short string describing its purpose.

    - [**`description`**](#attr-policy_bindings-condition-description): *(Optional `string`)*<a name="attr-policy_bindings-condition-description"></a>

      An optional description of the expression. This is a longer text which describes the expression, e.g. when hovered over it in a UI.

## Module Outputs

The following attributes are exported in the outputs of the module:

- [**`module_enabled`**](#output-module_enabled): *(`bool`)*<a name="output-module_enabled"></a>

  Whether this module is enabled.

- [**`repository`**](#output-repository): *(`object(repository)`)*<a name="output-repository"></a>

  All `google_artifact_registry_repository` resource attributes.

- [**`iam`**](#output-iam): *(`list(iam)`)*<a name="output-iam"></a>

  The `iam` resource objects that define the access to the resources.

## External Documentation

### Google Documentation

- https://cloud.google.com/artifact-registry

### Terraform Google Provider Documentation:

- https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/artifact_registry_repository

## Module Versioning

This Module follows the principles of [Semantic Versioning (SemVer)].

Given a version number `MAJOR.MINOR.PATCH`, we increment the:

1. `MAJOR` version when we make incompatible changes,
2. `MINOR` version when we add functionality in a backwards compatible manner, and
3. `PATCH` version when we make backwards compatible bug fixes.

### Backwards compatibility in `0.0.z` and `0.y.z` version

- Backwards compatibility in versions `0.0.z` is **not guaranteed** when `z` is increased. (Initial development)
- Backwards compatibility in versions `0.y.z` is **not guaranteed** when `y` is increased. (Pre-release)

## About Mineiros

[Mineiros][homepage] is a remote-first company headquartered in Berlin, Germany
that solves development, automation and security challenges in cloud infrastructure.

Our vision is to massively reduce time and overhead for teams to manage and
deploy production-grade and secure cloud infrastructure.

We offer commercial support for all of our modules and encourage you to reach out
if you have any questions or need help. Feel free to email us at [hello@mineiros.io] or join our
[Community Slack channel][slack].

## Reporting Issues

We use GitHub [Issues] to track community reported issues and missing features.

## Contributing

Contributions are always encouraged and welcome! For the process of accepting changes, we use
[Pull Requests]. If you'd like more information, please see our [Contribution Guidelines].

## Makefile Targets

This repository comes with a handy [Makefile].
Run `make help` to see details on each available target.

## License

[![license][badge-license]][apache20]

This module is licensed under the Apache License Version 2.0, January 2004.
Please see [LICENSE] for full details.

Copyright &copy; 2020-2022 [Mineiros GmbH][homepage]


<!-- References -->

[homepage]: https://mineiros.io/?ref=terraform-google-artifact-registry-repository
[hello@mineiros.io]: mailto:hello@mineiros.io
[badge-build]: https://github.com/mineiros-io/terraform-google-artifact-registry-repository/workflows/Tests/badge.svg
[badge-semver]: https://img.shields.io/github/v/tag/mineiros-io/terraform-google-artifact-registry-repository.svg?label=latest&sort=semver
[badge-license]: https://img.shields.io/badge/license-Apache%202.0-brightgreen.svg
[badge-terraform]: https://img.shields.io/badge/Terraform-1.x-623CE4.svg?logo=terraform
[badge-slack]: https://img.shields.io/badge/slack-@mineiros--community-f32752.svg?logo=slack
[build-status]: https://github.com/mineiros-io/terraform-google-artifact-registry-repository/actions
[releases-github]: https://github.com/mineiros-io/terraform-google-artifact-registry-repository/releases
[releases-terraform]: https://github.com/hashicorp/terraform/releases
[badge-tf-gcp]: https://img.shields.io/badge/google-3.x-1A73E8.svg?logo=terraform
[releases-google-provider]: https://github.com/terraform-providers/terraform-provider-google/releases
[apache20]: https://opensource.org/licenses/Apache-2.0
[slack]: https://mineiros.io/slack
[terraform]: https://www.terraform.io
[gcp]: https://cloud.google.com/
[semantic versioning (semver)]: https://semver.org/
[variables.tf]: https://github.com/mineiros-io/terraform-google-artifact-registry-repository/blob/main/variables.tf
[examples/]: https://github.com/mineiros-io/terraform-google-artifact-registry-repository/blob/main/examples
[issues]: https://github.com/mineiros-io/terraform-google-artifact-registry-repository/issues
[license]: https://github.com/mineiros-io/terraform-google-artifact-registry-repository/blob/main/LICENSE
[makefile]: https://github.com/mineiros-io/terraform-google-artifact-registry-repository/blob/main/Makefile
[pull requests]: https://github.com/mineiros-io/terraform-google-artifact-registry-repository/pulls
[contribution guidelines]: https://github.com/mineiros-io/terraform-google-artifact-registry-repository/blob/main/CONTRIBUTING.md
