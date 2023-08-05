variable "aws_access_key" {
  type        = string
  description = "AWS Access Key"
  sensitive   = true

}

variable "aws_secret_key" {
  type        = string
  description = "AWS Secret Key"
  sensitive   = true

}

variable "env" {
  type = string
  default = "dev"
  
}

variable "ssh-location" {
default = "0.0.0.0/0"
description = "SSH variable for bastion host"
type = string
}

variable key_name {
default     = "LL-TEST"
type = string
}

variable "aws_region" {
  type        = string
  description = "AWS region to deploy resources"
  default     = "eu-west-2"
}

variable "aws_vpc_cidr_block" {
  type        = string
  description = "VPC CIDR Block Range"
  default     = "10.0.0.0/16"
}


variable "ingress_from" {
  type        = number
  description = "Port for ingress from"
  default     = 22

}

variable "ingress_to" {
  type        = number
  description = "Port for ingress to"
  default     = 22
}

variable "ingress_cidr_block" {
  type        = list(string)
  description = "Ingress Cidr block range"
  default     = ["0.0.0.0/0"]
}

variable "egress_from" {
  type        = number
  description = "Port for Egress from"
  default     = 0
}

variable "egress_to" {
  type        = number
  description = "Port for egress to"
  default     = 0

}

variable "egress_cidr_block" {
  type        = list(any)
  description = "Egress CIDR Block range"
  default     = ["0.0.0.0/0"]

}

variable "cidr_block" {
  type = string
  default = "0.0.0.0/0"

}

variable "ec2_instance_size" {
  type        = string
  description = "The size of EC2 Instance"
  default     = "t2.micro"

}

variable "company" {
  type    = string
  default = "RollingGroseAnalytics"

}

variable "project" {
  type        = string
  description = "Our Project Name"
  default     = "ChrisandAlex"
}

variable "billing" {
  type        = string
  description = "Where the money gets taken from"
  default     = "My poor bank"

}