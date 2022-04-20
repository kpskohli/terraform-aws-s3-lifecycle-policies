output "s3_bucket_id" {
  description = "The name of the bucket."
  value       = concat(aws_s3_bucket.s3_bucket.*.id, [""])[0]
}

output "s3_bucket_arn" {
  description = "The ARN of the bucket. Will be of format arn:aws:s3:::bucketname."
  value       = concat(aws_s3_bucket.s3_bucket.*.arn, [""])[0]
}

output "s3_bucket_region" {
  description = "The AWS region this bucket resides in."
  value       = concat(aws_s3_bucket.s3_bucket.*.region, [""])[0]
}

