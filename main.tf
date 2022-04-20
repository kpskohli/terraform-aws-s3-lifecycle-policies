resource "aws_s3_bucket" "s3_bucket" {

  bucket = var.name

  acl           = var.acl
  force_destroy = var.force_destroy

  dynamic "server_side_encryption_configuration" {
    for_each = var.sse_config

    content {
      rule {
        apply_server_side_encryption_by_default {
          sse_algorithm     = server_side_encryption_configuration.value.sse_key == "S3" ? "AES256" : "aws:kms"
          kms_master_key_id = server_side_encryption_configuration.value.sse_key == "S3" ? "" : server_side_encryption_configuration.value.sse_key
        }
      }
    }
  }

  dynamic "versioning" {
    for_each = var.versioning_config

    content {
      enabled    = lookup(versioning.value, "enabled", false)
      mfa_delete = lookup(versioning.value, "mfa_delete", false)
    }
  }

  dynamic "lifecycle_rule" {
    for_each = var.lifecycle_rules

    content {
      id      = lifecycle_rule.value.id
      prefix  = lifecycle_rule.value.prefix
      tags    = lifecycle_rule.value.tags
      enabled = lifecycle_rule.value.enabled

      abort_incomplete_multipart_upload_days = lifecycle_rule.value.abort_incomplete_multipart_upload_days

      dynamic "expiration" {
        for_each = lifecycle_rule.value.expiration_config

        content {
          days                         = expiration.value.days
          expired_object_delete_marker = expiration.value.expired_object_delete_marker
        }
      }

      dynamic "noncurrent_version_expiration" {
        for_each = lifecycle_rule.value.noncurrent_version_expiration_config

        content {
          days = noncurrent_version_expiration.value.days
        }
      }

      dynamic "transition" {
        for_each = lifecycle_rule.value.transitions_config

        content {
          days          = transition.value.days
          storage_class = transition.value.storage_class
        }
      }

      dynamic "noncurrent_version_transition" {
        for_each = lifecycle_rule.value.noncurrent_version_transitions_config

        content {
          days          = noncurrent_version_transition.value.days
          storage_class = noncurrent_version_transition.value.storage_class
        }
      }
    }
  }

  tags = merge(
    {
      "Name" = format("%s", var.name)
    },
    var.tags
  )
}