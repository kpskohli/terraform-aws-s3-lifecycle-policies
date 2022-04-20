variable "name" {
  description = "(Required) The name of the bucket"
  type        = string
}

variable "acl" {
  description = "(Optional- Defaults to 'private') Amazon S3 access control lists (ACLs) enable you to manage access to buckets and objects"
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
  description = "(Optional) A map of tags to apply to all resources"
  type        = map(string)
  default     = {}
}

variable "lifecycle_rules" {
  description = "(Optional) A data structure to create lifcycle rules"
  type = list(object({
    id                                     = string
    prefix                                 = string
    tags                                   = map(string)
    enabled                                = bool
    abort_incomplete_multipart_upload_days = number
    expiration_config = list(object({
      days                         = number
      expired_object_delete_marker = bool
    }))
    noncurrent_version_expiration_config = list(object({
      days = number
    }))
    transitions_config = list(object({
      days          = number
      storage_class = string
    }))
    noncurrent_version_transitions_config = list(object({
      days          = number
      storage_class = string
    }))
  }))
  default = []
}