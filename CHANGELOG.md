# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

### Changed

- Remove Terraform `tomap` function use from `iam` module locals.
- Change `var.location` back to be optional.

## [0.0.4]

### Added

- Test additional resources in unit tests also

### Fixed

- Fixed iam integration when `module_enabled = false`

## [0.0.3]

### Added

- Add unit tests

### Changed

- Refactored `timeouts` block to match template standard
- Upgrade [terraform-google-artifact-registry-repository-iam](https://github.com/mineiros-io/terraform-google-artifact-registry-repository-iam) to `v0.0.3`
- BREAKING: `var.location` needs to be mandatory.

### Removed

- Removed default values in timeouts 

## [0.0.2]

### Added

- Support for provider 4.x

## [0.0.1]

### Added

- Initial Implementation

[unreleased]: https://github.com/mineiros-io/terraform-google-artifact-registry-repository/compare/v0.0.4...HEAD
[0.0.4]: https://github.com/mineiros-io/terraform-google-artifact-registry-repository/compare/v0.0.3...v0.0.4
[0.0.3]: https://github.com/mineiros-io/terraform-google-artifact-registry-repository/compare/v0.0.2...v0.0.3
[0.0.2]: https://github.com/mineiros-io/terraform-google-artifact-registry-repository/compare/v0.0.1...v0.0.2
[0.0.1]: https://github.com/mineiros-io/terraform-google-artifact-registry-repository/releases/tag/v0.0.1
