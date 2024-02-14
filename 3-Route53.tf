data "aws_acm_certificate" "cert" {
  domain      = "passporteddy.com"
  statuses    = ["ISSUED"]
  most_recent = true
}

resource "aws_acm_certificate_validation" "dns_validation" {
  certificate_arn         = data.aws_acm_certificate.cert.arn
  validation_record_fqdns = aws_route53_record.www.records
}

data "aws_route53_zone" "main" {
  name         = "passporteddy.com"  ## The domain name you want to look up
  private_zone = false
}

resource "aws_route53_record" "www" {
  zone_id = data.aws_route53_zone.main.zone_id
  name    = "passporteddy.com"
  type    = "A"

  alias {
    name                   = aws_cloudfront_distribution.asiafront.domain_name
    zone_id                = aws_cloudfront_distribution.asiafront.hosted_zone_id
    evaluate_target_health = true
  }
}