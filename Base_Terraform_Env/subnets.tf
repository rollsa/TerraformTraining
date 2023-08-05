resource "aws_subnet" "subnet-dsate" {
  cidr_block = "${cidrsubnet(aws_vpc.dstate-dev.cidr_block, 3, 1)}"
  vpc_id = aws_vpc.dstate-dev.id
  availability_zone = "eu-west-2a"
  tags = local.common_tags
}

resource "aws_route_table" "route-table-dstate-dev" {
  vpc_id = aws_vpc.dstate-dev.id
route {
    cidr_block = var.cidr_block
    gateway_id = aws_internet_gateway.dstate-dev-gw.id
  }
tags = local.common_tags
}
resource "aws_route_table_association" "subnet-association" {
  subnet_id      = aws_subnet.subnet-dsate.id
  route_table_id = aws_route_table.route-table-dstate-dev.id
}