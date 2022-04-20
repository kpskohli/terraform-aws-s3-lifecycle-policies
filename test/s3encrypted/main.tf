resource "aws_kms_key" "encrypt_s3" {
  count       = 1
  description = "KMS key to encrypt S3 bucket"
}

module "s3_kms_cmk" {
  source = "../../"

  name = "cu-s3-kms-cmk"

  sse_config = [{
    sse_key = concat(aws_kms_key.encrypt_s3.*.id, [""])[0]
    #sse_key = "s3"
  }]
}