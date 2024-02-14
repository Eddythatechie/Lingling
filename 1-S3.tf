locals {
  s3_origin_id = "mys3_origin_id"
}

resource "aws_s3_bucket" "ling54" {
  bucket = "ling54"

  tags = {
    Name = "ling54"
  }
}

resource "aws_s3_bucket_versioning" "versioning_lingling" {
  bucket = aws_s3_bucket.ling54.id
  versioning_configuration {
    status = "Disabled"
  }
}

resource "aws_s3_bucket_ownership_controls" "ling54" {
  bucket = aws_s3_bucket.ling54.id
  rule {
    object_ownership = "BucketOwnerPreferred"
  }
}

resource "aws_s3_bucket_public_access_block" "public_access_block" {
  bucket = aws_s3_bucket.ling54.id

  block_public_acls       = false
  block_public_policy     = false
  ignore_public_acls      = false
  restrict_public_buckets = false
}

resource "aws_s3_bucket_acl" "ling54" {
  bucket = aws_s3_bucket.ling54.id
  acl    = "public-read"
}

resource "aws_s3_object" "text_file" {
  bucket       = aws_s3_bucket.ling54.id
  key          = "index.html"
  acl          = "public-read"
  source       = "/Users/paul/Documents/ling/index.html"
  content_type = "text/html"
}

resource "aws_s3_object" "japanai1" {
  bucket = "ling54"
  key    = "japanai1.jpeg"
  acl    = "public-read"
  source = "/Users/paul/Documents/ling/japanai1.jpeg"
}

resource "aws_s3_object" "japanai2" {
  bucket = "ling54"
  key    = "japanai2.jpeg"
  acl    = "public-read"
  source = "/Users/paul/Documents/ling/japanai2.jpeg"
}

resource "aws_s3_bucket_website_configuration" "ling54" {
  bucket = aws_s3_bucket.ling54.id
  index_document {
    suffix = "index.html"
  }

  error_document {
    key = "error.html"
  }
}

resource "aws_cloudfront_origin_access_identity" "my_origin_access_identity" {
  comment = "My CloudFront Origin Access Identity"
}


data "aws_iam_policy_document" "s3_policy" {
  statement {
    actions   = ["s3:GetObject"]
    resources = ["${aws_s3_bucket.ling54.arn}/*"]

    principals {
      type        = "AWS"
      identifiers = [aws_cloudfront_origin_access_identity.my_origin_access_identity.iam_arn]
    }
  }
}

resource "aws_s3_bucket_policy" "ling54" {
  bucket = aws_s3_bucket.ling54.id
  policy = data.aws_iam_policy_document.s3_policy.json
}