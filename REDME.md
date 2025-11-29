# AWS Jenkins CI/CD Server Deployment (Infrastructure as Code)

## 1. Project Synopsis

This repository contains the **Terraform** configuration files necessary to provision a resilient and secure **Jenkins Continuous Integration (CI) Server** on the **Amazon Web Services (AWS)** cloud platform. The architecture emphasizes high availability, secure networking, and automated application bootstrap, adhering strictly to Infrastructure as Code (IaC) best practices.

## 2. Technical Stack

| Component | Technology | Purpose |
| :--- | :--- | :--- |
| **Cloud Platform** | AWS | Core cloud provider for all resources. |
| **Provisioning** | Terraform (IaC) | Declaratively manages the entire AWS infrastructure lifecycle. |
| **CI Application** | Jenkins | The Continuous Integration server deployed on the EC2 instance. |
| **OS** | Ubuntu 22.04+ (via AMI) | Base operating system for the EC2 compute instance. |
| **Configuration** | Bash Shell Scripting | Used via `user_data` for automated Jenkins and Java installation. |

## 3. Deployed Infrastructure Architecture

The configuration creates a dedicated, isolated networking environment and secures the Jenkins server:

* **VPC:** Custom Virtual Private Cloud for network isolation.
* **Subnet:** Single Public Subnet to host the accessible server.
* **Security Group:** Enforces a restrictive security posture, opening only essential ports.
* **EC2 Instance:** Launches the Jenkins application host.
* **Elastic IP (EIP):** Provides a static, persistent public address for the Jenkins endpoint.

## 4. Verification and Access Details

The following parameters represent the live resources provisioned by the successful Terraform run:

| Parameter | Value | Resource | Purpose |
| :--- | :--- | :--- | :--- |
| **Jenkins Endpoint** | `http://98.95.246.89:8080` | `aws_eip` | Stable public URL for the Jenkins dashboard. |
| **Instance Identifier** | `i-0bdb7a3460456e2dd` | `aws_instance` | Unique ID for referencing the compute instance in AWS Console/CLI. |
| **Server Size** | `t2.micro` | `aws_instance` | Instance type utilized for deployment. |
| **SSH Key Pair** | `terraform` | `aws_instance` | Required Key Pair name for secure SSH connections. |
| **VPC Identifier** | `vpc-05db7ee8354012a47` | `aws_vpc` | Network boundary ID. |
| **Security Group ID** | `sg-0519789e5f7578848` | `aws_security_group` | Firewall boundary enforcing port access rules. |

## 5. Deployment and Operations

### Prerequisites

1.  AWS Account with configured credentials (CLI profile).
2.  Terraform CLI installed.
3.  Required **Key Pair** (`terraform`) must exist in the target AWS Region (`us-east-1`).

### Deployment Steps

1.  **Initialization:**
    ```bash
    terraform init
    ```
2.  **Validation & Planning:** Review the infrastructure changes before applying.
    ```bash
    terraform plan
    ```
3.  **Execution (Provisioning):**
    ```bash
    terraform apply --auto-approve
    ```

### Post-Deployment Verification (First Login)

1.  **Access Web UI:** Navigate to the Jenkins Endpoint: `http://98.95.246.89:8080`
2.  **Retrieve Initial Password:** The setup script automatically configures Jenkins. Retrieve the administrator password via SSH:
    ```bash
    # Connect using the Key Pair
    ssh -i /path/to/your/terraform.pem ubuntu@98.95.246.89
    
    # Retrieve the password from the installation log
    sudo cat /var/lib/jenkins/secrets/initialAdminPassword
    ```
3.  Use the retrieved password in the browser to unlock Jenkins and complete the setup.

### Teardown (Destruction)

To ensure the environment is fully de-provisioned and to prevent recurring charges, execute the following command:

```bash
terraform destroy --auto-approve
