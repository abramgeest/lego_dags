data "aws_caller_identity" "current" {}

locals {
#   azs         = slice(data.aws_availability_zones.available.names, 0, 2)
  bucket_name = format("%s-%s", "aws-ia-mwaa", data.aws_caller_identity.current.account_id)
}

#-----------------------------------------------------------
# Create an S3 bucket and upload sample DAG
#-----------------------------------------------------------
#tfsec:ignore:AWS017 tfsec:ignore:AWS002 tfsec:ignore:AWS077
resource "aws_s3_bucket" "this" {
  bucket = local.bucket_name
  tags   = var.tags
}

resource "aws_s3_bucket_server_side_encryption_configuration" "this" {
  bucket = aws_s3_bucket.this.id

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}

resource "aws_s3_bucket_public_access_block" "this" {
  bucket                  = aws_s3_bucket.this.id
  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

# Upload DAGS
resource "aws_s3_object" "object1" {
  for_each = fileset("dags/", "*")
  bucket   = aws_s3_bucket.this.id
  key      = "dags/${each.value}"
  source   = "dags/${each.value}"
  etag     = filemd5("dags/${each.value}")
}

# Upload plugins/requirements.txt
resource "aws_s3_object" "reqs" {
  for_each = fileset("mwaa/", "*")
  bucket   = aws_s3_bucket.this.id
  key      = each.value
  source   = "mwaa/${each.value}"
  etag     = filemd5("mwaa/${each.value}")
}