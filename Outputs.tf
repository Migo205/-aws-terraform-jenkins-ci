output "public_subnet_id" {
  description = "ID of the public subnet"
  value       = aws_subnet.public.id
}

output "vpc_id" {
  description = "ID of the VPC"
  value       = aws_vpc.my_vpc.id
}

output "sg_id" {
  description = "The ID of the security group"
  value       = aws_security_group.jenkins_sg.id
}

output "jenkins_server_public_ip" {
  description = "The public IP address of the Jenkins server (Elastic IP)"
  value       = aws_eip.ec2_eip.public_ip
}

output "jenkins_server_instance_id" {
  description = "The ID of the Jenkins EC2 instance"
  value       = aws_instance.jenkins_instance.id
}

