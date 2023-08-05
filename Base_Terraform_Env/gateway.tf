resource "aws_internet_gateway" "dstate-dev-gw" {
  vpc_id = aws_vpc.dstate-dev.id
tags = local.common_tags
}