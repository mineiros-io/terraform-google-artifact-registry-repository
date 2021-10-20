# ------------------------------------------------------------------------------
# OUTPUT CALCULATED VARIABLES (prefer full objects)
# ------------------------------------------------------------------------------

# remap iam to reduce one level of access (iam[]. instead of iam[].iam.)
output "iam" {
  description = "The iam resource objects that define the access to the secret"
  value       = { for key, iam in module.iam : key => iam.iam }
}

# ------------------------------------------------------------------------------
# OUTPUT ALL RESOURCES AS FULL OBJECTS
# ------------------------------------------------------------------------------

output "repository" {
  description = "All `google_artifact_registry_repository` resource attributes."
  value       = try(google_artifact_registry_repository.repository[0], null)
}

# ------------------------------------------------------------------------------
# OUTPUT ALL INPUT VARIABLES
# ------------------------------------------------------------------------------

# ------------------------------------------------------------------------------
# OUTPUT MODULE CONFIGURATION
# ------------------------------------------------------------------------------

output "module_enabled" {
  description = "Whether the module is enabled."
  value       = var.module_enabled
}
