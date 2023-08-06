resource "aws_security_group" "ingress-all-dstate-dev" {
name = "allow-all-sg"
vpc_id = aws_vpc.dstate-dev.id
ingress {
    cidr_blocks = var.ingress_cidr_block
    from_port = var.ingress_from_ssh
    to_port = var.ingress_to_ssh
    protocol = "tcp"
  }

  ingress {
    cidr_blocks = var.ingress_cidr_block
    from_port = var.ingress_from_airflow
    to_port = var.ingress_to_airflow
    protocol = "tcp"
  } 
// Terraform removes the default rule
  egress {
   from_port = var.egress_from
   to_port = var.egress_to
   protocol = "-1"
   cidr_blocks = var.egress_cidr_block
 }
}