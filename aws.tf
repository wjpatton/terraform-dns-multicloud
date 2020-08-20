data "aws_route53_zone" "main" {
  name = var.hosted-zone
}

# AWS SUBZONE

resource "aws_route53_zone" "aws_sub_zone" {
  count   = var.create_aws_dns_zone ? 1 : 0
  name    = "${var.namespace}.aws.${var.hosted-zone}"
  comment = "Managed by Terraform, Delegated Sub Zone for AWS for ${var.namespace}"

  tags = {
    name       = var.namespace
    owner      = var.owner
    created-by = var.created-by
    ttl        = "-1"
  }
}

resource "aws_route53_record" "aws_sub_zone_ns" {
  count   = var.create_aws_dns_zone ? 1 : 0
  zone_id = data.aws_route53_zone.main.zone_id
  name    = "${var.namespace}.aws.${var.hosted-zone}"
  type    = "NS"
  ttl     = "30"

  records = [
    for awsns in aws_route53_zone.aws_sub_zone.0.name_servers :
    awsns
  ]
}
