provider "aws" {
  region = "us-east-1"
}

resource "aws_route53_zone" "example" {
  name = "example.com"
}

resource "aws_cloudfront_distribution" "example" {
  origin {
    domain_name = "example.com"
    origin_id   = "example-origin"
  }
  enabled             = true
  is_ipv6_enabled      = true
  comment              = "CloudFront Distribution"
  default_root_object  = "index.html"

  default_cache_behavior {
    target_origin_id = "example-origin"
    viewer_protocol_policy = "redirect-to-https"
  }
}

resource "aws_elastic_beanstalk_environment" "example" {
  name                = "example-env"
  application         = aws_elastic_beanstalk_application.example.name
  solution_stack_name = "64bit Amazon Linux 2 v3.4.6 running Node.js 14"
  settings = [
    {
      namespace = "aws:elasticbeanstalk:environment"
      option_name = "EnvironmentType"
      value = "LoadBalanced"
    }
  ]
}

resource "aws_db_instance" "example" {
  identifier        = "example-db"
  engine            = "mysql"
  instance_class    = "db.t2.micro"
  allocated_storage = 20
  username          = "admin"
  password          = "password"
}
