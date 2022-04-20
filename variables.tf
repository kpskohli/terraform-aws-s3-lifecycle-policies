variable "name" {
  description = "(Required) The name of the bucket."
  type        = string
}

variable "acl" {
  description = "(Optional - Defaults to 'private') Amazon S3 access control lists (ACLs) enable you to manage access to buckets and objects"
  default     = "private"
}

variable "force_destroy" {
  description = "(Optional - Defaults to false) A boolean that indicates all objects should be deleted from the bucket so that the bucket can be destroyed without error. These objects are not recoverable. When set to true, will delete the bucket even if it is not empty"
  type        = bool
  default     = false
}

variable "sse_config" {
  description = "(Optional - Default disabled) Configures server side encryption for the bucket. The sse_key should either be set to S3 or a KMS Key ID"
  type = list(object({
    sse_key = string
  }))
  default = []
}

variable "versioning_config" {
  description = "(Optional) Configure versioning on bucket object. Once you version-enable a bucket, it can never return to an unversioned state. You can, however, suspend versioning on that bucket"
  type        = list(map(string))
  default     = []
}

variable "tags" {
  description = "(Optional) A map of tags to apply to all resources."
  type        = map(string)
  default     = {}
}

variable "lifecycle_rules" {
  description = "(Optional) List of maps containing configuration of object lifecycle management."
  type        = any
  default     = []

  # Example:
  #
  # lifecycle_rules = [
  #   {
  #     id      = "log"
  #     enabled = true
  #
  #     prefix = "log/"
  #
  #     tags = {
  #       "rule"      = "log"
  #       "autoclean" = "true"
  #     }
  #
  #     transition = [
  #       {
  #         days          = 30
  #         storage_class = "STANDARD_IA" # or "ONEZONE_IA"
  #       },
  #       {
  #         days          = 60
  #         storage_class = "GLACIER"
  #       }
  #     ]
  #
  #     expiration = {
  #       days = 90
  #     }
  #   }
  # ]
}