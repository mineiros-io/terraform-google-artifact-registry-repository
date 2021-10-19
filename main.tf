resource "google_artifact_registry_repository" "repository" {
  provider = google-beta
  count    = var.module_enabled ? 1 : 0

  depends_on = [var.module_depends_on]

  repository_id = var.repository_id
  format        = var.format
  location      = var.location
  description   = var.description
  labels        = var.labels
  kms_key_name  = var.kms_key_name
  project       = var.project

  timeouts {
    create = try(var.timeouts.create, "4m")
    update = try(var.timeouts.update, "4m")
    delete = try(var.timeouts.delete, "4m")
  }
}
