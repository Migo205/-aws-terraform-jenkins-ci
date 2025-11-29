Markdown# AWS Terraform Jenkins CI/CD Deployment

[![GitHub license](https://img.shields.io/github/license/Migo205/-aws-terraform-jenkins-ci)](https://github.com/Migo205/-aws-terraform-jenkins-ci/blob/main/LICENSE)
[![Terraform Version](https://img.shields.io/badge/Terraform-%3E%3D1.0-blue.svg)](https://www.terraform.io/downloads.html)
[![AWS Provider](https://img.shields.io/badge/AWS-Provider%205.0%2B-orange.svg)](https://registry.terraform.io/providers/hashicorp/aws/latest)

## Overview

This repository provides a complete **Infrastructure as Code (IaC)** solution using Terraform to deploy a **production-ready Jenkins CI/CD server** on AWS.

The setup includes:

- Custom VPC with public and private subnets
- Multi-AZ architecture (us-east-1a & us-east-1b)
- NAT Gateways for outbound internet access from private resources
- Auto-configured EC2 instance running Jenkins (installed via user data)
- Secure networking with Internet Gateway, route tables, and least-privilege Security Groups
- Free-tier eligible and highly cost-effective

Perfect for DevOps learners, certification labs, interviews, or real team environments.

## Architecture Summary
Internet Gateway
│
Public Subnets (ALB / Bastion / NAT)
│
Private Subnets (Future app/DB tier)
│
NAT Gateway (per AZ) → Outbound internet
text## Prerequisites

- AWS account (Free Tier works perfectly)
- Terraform ≥ 1.0 installed
- AWS CLI configured (optional but helpful)
- Git

## Quick Start

```bash
git clone https://github.com/Migo205/-aws-terraform-jenkins-ci.git
cd -aws-terraform-jenkins-ci

terraform init
terraform validate
terraform plan
terraform apply
Deployment completes in ~5–10 minutes.
Access Your Jenkins Server
After apply, you will see:
textOutputs:
jenkins_url = "http://ec2-xx-xx-xx-xx.compute-1.amazonaws.com:8080"
Open the URL → Unlock Jenkins → Get initial admin password from instance logs or SSM Session Manager.
Cleanup (Important – Avoid Charges!)
Bashterraform destroy
Project Structure
text├── main.tf           # Core resources (VPC, EC2, Jenkins, etc.)
├── variables.tf      # Input variables
├── terraform.tfvars  # Your custom values
├── outputs.tf        # Useful outputs (Jenkins URL, IPs)
├── provider.tf       # AWS provider configuration
├── security.tf       # Security Groups and rules
└── README.md         # This file
Future Enhancements (Ready to Add)

Application Load Balancer in front of Jenkins
Auto Scaling Group for Jenkins agents
Multi-AZ RDS database
Remote S3 backend + DynamoDB locking
HTTPS with ACM certificate

Contributing
Contributions, issues, and feature requests are welcome!
Feel free to fork and submit pull requests.
License
This project is licensed under the MIT License – see the LICENSE file for details.

Built with passion for clean, repeatable, and professional DevOps practices.
Last updated: November 2025
If this helped you in your lab, certification, or job interview — don’t forget to star the repo!
