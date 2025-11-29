AWS Multi-Tier Web Application with Terraform (Full Production-Ready Lab)

Terraform ≥1.5       AWS Cloud       MIT License

This repository contains a complete, production-grade Terraform project that deploys a highly available, multi-tier web application on AWS — exactly as required in most advanced AWS + Terraform hands-on labs and real-world interviews.

Architecture Overview
Internet
   ↓
Application Load Balancer (Public Subnets) ← ALBSG (port 80 open)
   ↓
┌─────────────────────┐          ┌─────────────────────┐
│ Private Subnet AZ-a │          │ Private Subnet AZ-b │
│   EC2 Web Server 1  │◄──────►──│   EC2 Web Server 2  │
└─────────────────────┘          └─────────────────────┘
         ↓                               ↓
     NAT Gateway ◄─────────────────────► NAT Gateway
         ↓                               ↓
   Public Subnet AZ-a               Public Subnet AZ-b
         ↓                               ↓
         └───────────── IGW ◄────────────┘

Resources Created
┌─────────────────────────────────┬───────┬─────────────────────┬──────────────────────────────────────────┐
│ Resource                        │ Count │ Location            │ Purpose                                  │
├─────────────────────────────────┼───────┼─────────────────────┼──────────────────────────────────────────┤
│ Custom VPC                      │ 1     │ -                   │ Isolated network                         │
│ Public Subnets                  │ 2     │ Multi-AZ            │ ALB & NAT Gateways                       │
│ Private Subnets                 │ 2     │ Multi-AZ            │ Web/App tier (EC2)                       │
│ NAT Gateways + EIPs             │ 2     │ One per AZ          │ Outbound internet from private subnets   │
│ EC2 Instances (Amazon Linux)    │ 2     │ Private subnets     │ Web servers with Apache + custom message │
│ EBS Encryption                  │ Yes   │ Root volumes        │ Encrypted at rest                        │
│ Security Group (webSG)          │ 1     │ Private instances   │ SSH/HTTP/HTTPS only from ALB             │
│ Application Load Balancer       │ 1     │ Public subnets      │ Load balancing + health checks           │
└─────────────────────────────────┴───────┴─────────────────────┴──────────────────────────────────────────┘

Features & Best Practices Implemented
• Full multi-AZ high availability
• Private instances with no public IPs
• NAT Gateway per AZ (no single point of failure)
• EBS root volumes encrypted at rest
• Security groups with least privilege
• Clean, modular Terraform code
• Ready for Auto Scaling & RDS extensions

Quick Start
git clone https://github.com/Migo205/-aws-terraform-jenkins-ci.git
cd -aws-terraform-jenkins-ci
terraform init && terraform apply

After ~8 minutes you’ll get:
alb_dns_name = "web-alb-123456789.us-east-1.elb.amazonaws.com"

Open it → You’ll see the custom message from one of your private servers!

Cleanup (Important!)
terraform destroy

Made with Passion for Cloud & DevOps
Last updated: November 2025

If this helped you pass your lab or interview — don’t forget to give it a Star!
