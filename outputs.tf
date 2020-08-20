output "aws_sub_zone_id" {
  value = var.create_aws_dns_zone ? aws_route53_zone.aws_sub_zone[0].zone_id : ""
}

output "aws_sub_zone_nameservers" {
  value = var.create_aws_dns_zone ? aws_route53_zone.aws_sub_zone[0].name_servers : []
}
