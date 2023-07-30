##################################################################################
# PROVIDERS
##################################################################################

provider "aws" {
  access_key = "AKIAZ4WA34LK2NR227V3"
  secret_key = "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"
  region     = "eu-west-2"
}

##################################################################################
# DATA
##################################################################################

data "aws_ssm_parameter" "amzn2_linux" {
  name = "/aws/service/ami-amazon-linux-latest/amzn2-ami-hvm-x86_64-gp2"
}

##################################################################################
# RESOURCES
##################################################################################

# NETWORKING #
resource "aws_vpc" "destate" {
  cidr_block           = "10.0.0.0/16"
  enable_dns_hostnames = true

}

resource "aws_internet_gateway" "destate" {
  vpc_id = aws_vpc.destate.id

}

resource "aws_subnet" "public_subnet1" {
  cidr_block              = "10.0.0.0/24"
  vpc_id                  = aws_vpc.destate.id
  map_public_ip_on_launch = true
}

# ROUTING #
resource "aws_route_table" "destate" {
  vpc_id = aws_vpc.destate.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.destate.id
  }
}

resource "aws_route_table_association" "destate_subnet1" {
  subnet_id      = aws_subnet.public_subnet1.id
  route_table_id = aws_route_table.destate.id
}

# SECURITY GROUPS #
# Nginx security group 
resource "aws_security_group" "destate_sg" {
  name   = "destate_sg"
  vpc_id = aws_vpc.destate.id

  # HTTP access from anywhere
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # outbound internet access
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# INSTANCES #
resource "aws_instance" "etl" {
  ami                    = nonsensitive(data.aws_ssm_parameter.amzn2_linux.value)
  instance_type          = "t2.micro"
  subnet_id              = aws_subnet.public_subnet1.id
  vpc_security_group_ids = [aws_security_group.destate_sg.id]

  user_data = <<EOF
#! /bin/bash
sudo amazon-linux-extras install -y nginx1
sudo service nginx start
sudo rm /usr/share/nginx/html/index.html
echo '<html><head><title>Taco Team Server</title></head><body style=\"background-color:#1F778D\"><p style=\"text-align: center;\"><span style=\"color:#FFFFFF;\"><span style=\"font-size:28px;\">You did it! Have a &#127790;</span></span></p></body></html>' | sudo tee /usr/share/nginx/html/index.html
EOF

}