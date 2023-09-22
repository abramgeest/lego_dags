output "mwaa_s3_bucket" {
  description = " The status of the Amazon MWAA Environment"
  value       = aws_s3_bucket.this.arn
}