# ------------------------------------------------------------------------------
# OUTPUT CALCULATED VARIABLES (prefer full objects)
# ------------------------------------------------------------------------------

# ------------------------------------------------------------------------------
# OUTPUT ALL RESOURCES AS FULL OBJECTS
# ------------------------------------------------------------------------------

output "repository" {
  description = "All `google_artifact_registry_repository` resource attributes."
  value       = try(google_artifact_registry_repository.repository[0], null)
}
