data "aws_ssm_parameter" "amzn2_linux" {
  name = "/aws/service/ami-amazon-linux-latest/amzn2-ami-hvm-x86_64-gp2"
}

resource "tls_private_key" "key" {
algorithm = "RSA"
}

resource "local_file" "private_key" {
filename          = "TEST.pem"
sensitive_content = tls_private_key.key.private_key_pem
file_permission   = "0400"
}

resource "aws_key_pair" "key_pair" {
key_name   = "TEST"
public_key = tls_private_key.key.public_key_openssh
}

resource "aws_instance" "etl-ec2-instance" {
  ami = nonsensitive(data.aws_ssm_parameter.amzn2_linux.value)
  instance_type = var.ec2_instance_size
  key_name = "TEST"
  security_groups = [aws_security_group.ingress-all-dstate-dev.id]
tags = local.common_tags
subnet_id = aws_subnet.subnet-dsate.id
}