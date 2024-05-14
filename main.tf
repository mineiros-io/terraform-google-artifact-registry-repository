resource "google_artifact_registry_repository" "repository" {
  provider = google-beta
  count    = var.module_enabled ? 1 : 0

  depends_on = [var.module_depends_on]

  repository_id          = var.repository_id
  format                 = var.format
  location               = var.location
  description            = var.description
  labels                 = var.labels
  kms_key_name           = var.kms_key_name
  project                = var.project
  cleanup_policy_dry_run = var.cleanup_policy_dry_run
  dynamic "cleanup_policies" {
    for_each = var.cleanup_policies != null ? var.cleanup_policies : []

    content {
      id     = cleanup_policies.value.id
      action = cleanup_policies.value.action
      condition {
        tag_state             = cleanup_policies.value.condition.tag_state
        tag_prefixes          = cleanup_policies.value.condition.tag_prefixes
        version_name_prefixes = cleanup_policies.value.condition.version_name_prefixes
        package_name_prefixes = cleanup_policies.value.condition.package_name_prefixes
        older_than            = cleanup_policies.value.condition.older_than
        newer_than            = cleanup_policies.value.condition.newer_than
      }
      most_recent_versions {
        package_name_prefixes = cleanup_policies.value.most_recent_versions.package_name_prefixes
        keep_count            = cleanup_policies.value.most_recent_versions.keep_count
      }
    }
  }

  timeouts {
    create = try(var.module_timeouts.google_artifact_registry_repository.create, null)
    update = try(var.module_timeouts.google_artifact_registry_repository.update, null)
    delete = try(var.module_timeouts.google_artifact_registry_repository.delete, null)
  }
}
