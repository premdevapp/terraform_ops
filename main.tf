terraform {
  required_providers {
    aws = {
      version = "~> 3.65.0"
    }
  }
}

provider "aws" {
  region  = "us-east-1"
}

resource "aws_instance" "web" {
  ami             = "ami-04ad2567c9e3d7893"
  instance_type   = "t2.micro"
  key_name        = "premAws"
  security_groups = [aws_security_group.web.name]
  tags = {
    Name = "webserverByTf"
  }
}

resource "aws_security_group" "web" {
  name        = "web-security-group"
  description = "Used in terraform acceptance tests"
  ingress {
    description = "Allow SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

}

output "instance_public_dns" {
  value = aws_instance.web.public_dns
}