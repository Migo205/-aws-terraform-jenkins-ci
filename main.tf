provider "aws" {
 region = "us-east-1"
 profile= "default"
}
resource "aws_vpc" "my_vpc" {
  cidr_block = "10.0.0.0/16"
}
resource "aws_instance" "web" {
  instance_type = "t2.micro"
  ami = "ami-0fa3fe0fa7920f68e"
  subnet_id = aws_subnet.public.id
  vpc_security_group_ids = [aws_security_group.jenkins_sg.id]
  user_data = file("${path.module}/script.sh")
  key_name  = "terraform"
  
  tags = {
    Name = "jenkins"
  }
}
