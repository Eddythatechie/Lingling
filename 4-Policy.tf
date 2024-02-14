resource "aws_s3_bucket_policy" "site" {
  
  bucket = aws_s3_bucket.ling54.id
  
 policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Sid       = "PublicReadGetObject"
        Effect    = "Allow"
        Principal = "*"
        Action    = "s3:GetObject"
        Resource  = "${aws_s3_bucket.ling54.arn}/*"
      },
      {
        Sid    = "CloudFrontOAIReadGetObject"
        Effect = "Allow"
        Principal = {
          AWS = "arn:aws:iam::cloudfront:user/CloudFront Origin Access Identity ${aws_cloudfront_origin_access_identity.asiafront-origin.id}"
        }
        Action   = "s3:GetObject"
        Resource = "${aws_s3_bucket.ling54.arn}/*"
      },
    ]
  })
}