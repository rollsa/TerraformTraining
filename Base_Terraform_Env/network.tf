resource "aws_vpc" "dstate-dev" {
  cidr_block = var.aws_vpc_cidr_block
  enable_dns_hostnames = true
  enable_dns_support = true
  tags = local.common_tags
}

resource "aws_eip" "ip-dstate-dev" {
  instance = aws_instance.etl-ec2-instance.id
}