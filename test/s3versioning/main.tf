module "s3_versioning" {
  source = "../../"

  name = "cu-s3-versioning"

  versioning_config = [{
    enabled = true
  }]
}

module "s3_versioning_mfa_delete" {
  source = "../../"

  name = "cu-s3-mfa-versioning"

  versioning_config = [{
    enabled    = true
    mfa_delete = true
  }]
}