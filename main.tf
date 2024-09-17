terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.16"
    }
  }

  required_version = ">= 1.2.0"
}

provider "aws" {
  region  = "eu-central-1"
}

resource "aws_security_group" "ec2_security_group" {
  name        = "ec2_security_group"
  description = "Security group for EC2 instance allowing HTTP and SSH access"


  ingress {
    description = "Allow SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "Allow HTTP"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }


  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "EC2SecurityGroup"
  }
}

resource "aws_instance" "test_server" {
  ami           = "ami-00f07845aed8c0ee7"
  instance_type = "t2.micro"
  vpc_security_group_ids = [aws_security_group.ec2_security_group.id]

  tags = {
    Name = "Test_New_Example"
  }
}
