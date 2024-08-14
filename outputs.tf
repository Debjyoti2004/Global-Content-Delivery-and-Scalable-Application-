output "cloudfront_domain_name" {
  value = aws_cloudfront_distribution.example.domain_name
}

output "elb_endpoint" {
  value = aws_elastic_beanstalk_environment.example.endpoint_url
}
