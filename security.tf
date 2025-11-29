# Create a Security Group for the EC2 Instance
resource "aws_security_group" "jenkins_sg" {
  name        = "jenkins-server-sg"
  description = "Allow inbound traffic for SSH and Jenkins 8080"
  vpc_id      = aws_vpc.my_vpc.id 

  ingress {
    description = "SSH from anywhere"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "Jenkins from anywhere"
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }


  egress { 
   
    description = "Allow all outbound traffic"
    from_port   = 0
    to_port     = 0
    protocol    = "-1" 
    cidr_blocks = ["0.0.0.0/0"]
  }
tags = {
    Name = "jenkins_sg"
  }


}
