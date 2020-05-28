variable "keyring_name" {
  type        = string
  description = "Name of the GCP KMS keyring."
}

variable "keyring_location" {
  type        = string
  default     = "us-west2"
  description = "Location of the GCP KMS keyring."

}

variable "keys" {
  type = list(object({
    key_name        = string,
    purpose         = string,
    rotation_period = string,
    version_template = object({
      algorithm        = string
      protection_level = string
    })
    permissions = list(object({
      members = list(string),
      role    = string,
      condition = object({
        title       = string,
        description = string,
        expression  = string
      })
    }))
  }))
  default     = []
  description = ""
}