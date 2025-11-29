provider "aws" {
 region = var.aws_region
 profile= "default"
}
# Define the VPC 
resource "aws_vpc" "my_vpc" {
  cidr_block = var.vpc_cidr
  enable_dns_hostnames = true
   tags = {
    Name        = var.vpc_name
    Terraform   = "true"
  }
}

data "aws_ami" "ubuntu" {
  most_recent = "true"

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"]
}


# Create the EC2 Instance 

resource "aws_instance" "jenkins_instance" {
  instance_type =  var.instance_type
  ami = data.aws_ami.ubuntu.id
  subnet_id = aws_subnet.public.id
  vpc_security_group_ids = [aws_security_group.jenkins_sg.id]
  user_data = file("${path.module}/jenkins_installation.sh")
  key_name  = "terraform"
  root_block_device {
    encrypted = true
  }
  tags = {
    Name = "jenkins"
  }
}
