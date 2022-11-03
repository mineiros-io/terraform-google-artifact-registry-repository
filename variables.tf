# ---------------------------------------------------------------------------------------------------------------------
# REQUIRED VARIABLES
# These variables must be set when using this module.
# ---------------------------------------------------------------------------------------------------------------------

variable "repository_id" {
  description = "(Required) The last part of the repository name, for example: 'repo1'."
  type        = string
}

# ---------------------------------------------------------------------------------------------------------------------
# OPTIONAL VARIABLES
# These variables have defaults, but may be overridden.
# ---------------------------------------------------------------------------------------------------------------------

variable "location" {
  description = "(Optional) The name of the location this repository is located in. If it is not provided, the provider location is used."
  type        = string
  default     = null
}


variable "format" {
  description = "(Optional) The format of packages that are stored in the repository. You can only create alpha formats if you are a member of the alpha user group. Possible values are `DOCKER`, `MAVEN`, `NPM`, `PYTHON`, `APT` (alpha), `YUM` (alpha)"
  type        = string
  default     = "DOCKER"
}

variable "description" {
  description = "(Optional) The user-provided description of the repository."
  type        = string
  default     = null
}

variable "labels" {
  description = "(Optional) Labels with user-defined metadata. This field may contain up to 64 entries. Label keys and values may be no longer than 63 characters. Label keys must begin with a lowercase letter and may only contain lowercase letters, numeric characters, underscores, and dashes."
  type        = map(string)
  default     = {}
}

variable "kms_key_name" {
  description = "(Optional) The Cloud KMS resource name of the customer managed encryption key that's used to encrypt the contents of the Repository. Has the form: projects/my-project/locations/my-region/keyRings/my-kr/cryptoKeys/my-key. This value may not be changed after the Repository has been created."
  type        = string
  default     = null
}

variable "project" {
  description = "(Optional) The ID of the project in which the resource belongs. If it is not provided, the provider project is used."
  type        = string
  default     = null
}

## IAM

variable "iam" {
  description = "(Optional) A list of IAM access."
  type        = any
  default     = []
}

variable "policy_bindings" {
  description = "(Optional) A list of IAM policy bindings."
  type        = any
  default     = null
}

# ------------------------------------------------------------------------------
# MODULE CONFIGURATION PARAMETERS
# These variables are used to configure the module.
# ------------------------------------------------------------------------------

variable "module_enabled" {
  type        = bool
  description = "(Optional) Whether to create resources within the module or not. Default is 'true'."
  default     = true
}

variable "module_timeouts" {
  description = "(Optional) How long certain operations (per resource type) are allowed to take before being considered to have failed."
  type        = any
  # type = object({
  #   google_artifact_registry_repository = optional(object({
  #     create = optional(string)
  #     update = optional(string)
  #     delete = optional(string)
  #   }))
  # })
  default = {}
}

variable "module_depends_on" {
  type        = any
  description = "(Optional) A list of external resources the module depends_on. Default is '[]'."
  default     = []
}
