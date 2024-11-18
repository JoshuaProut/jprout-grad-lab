output "s3_webfiles_arn" {
  value = module.s3_webfiles.s3_bucket_arn
}

output "vpc_id" {
  value = module.vpc.vpc_id
}
