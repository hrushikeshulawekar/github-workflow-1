#first install aws cli
#then confirm installation
#aws --version
#aws sts get-caller-identity
#install unzip

terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region = "ap-south-1" # Change to your preferred AWS region
}

# Automatically fetch the latest Ubuntu 24.04 LTS AMI
data "aws_ami" "ubuntu" {
  most_recent = true
  owners      = ["099720109477"] # Canonical

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd-gp3/ubuntu-noble-24.04-amd64-server-*"]
  }
}

# Create a t3.micro EC2 instance
resource "aws_instance" "demo_ec2" {
  ami           = data.aws_ami.ubuntu.id
  instance_type = "t3.micro"

  tags = {
    Name = "terraform-github-action-ec2"
  }
}

output "instance_id" {
  value = aws_instance.demo_ec2.id
}

output "public_ip" {
  value = aws_instance.demo_ec2.public_ip
}
