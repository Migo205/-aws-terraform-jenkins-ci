# AWS Jenkins CI/CD Server Deployment (Infrastructure as Code)

## 1. Project Overview and Methodology

This repository provides the **Terraform** configuration for deploying a robust and secure **Jenkins CI/CD Server** on **Amazon Web Services (AWS)**. This solution demonstrates key **DevOps** practices by treating infrastructure as code (IaC), ensuring automated, repeatable, and consistent deployment.

### Key Technologies Utilized:

* **Cloud Platform:** AWS
* **Provisioning Tool:** Terraform (Infrastructure as Code)
* **Application:** Jenkins CI/CD Server
* **OS/Bootstrap:** Ubuntu Linux & Custom Bash Scripting (`user_data`)

---

## 2. Infrastructure Architecture

The deployment creates a dedicated and secure network environment for the Jenkins server:

* **Network Isolation:** A custom **VPC** and a **Public Subnet** for isolation.
* **Security Posture:** A tightly configured **Security Group** restricting access to only essential ports (22, 8080).
* **Compute:** A dedicated **EC2 Instance** hosts the Jenkins application.
* **Stable Access:** An **Elastic IP (EIP)** is associated with the instance, providing a permanent, stable public endpoint.

---

## 3. Live Deployment Details (Verification)

The following parameters are the concrete outputs from the successful Terraform execution. Use these details for accessing and managing the provisioned resources:

### Jenkins Access Endpoint

* **Public URL:** `http://98.95.246.89:8080`
* **Associated Elastic IP:** `98.95.246.89`

### Core AWS Resource Identifiers

* **EC2 Instance ID:** `i-0bdb7a3460456e2dd` (Type: `t2.micro`)
* **VPC ID:** `vpc-05db7ee8354012a47`
* **Security Group ID:** `sg-0519789e5f7578848`
* **SSH Key Name:** `terraform` (Required for authentication)

---

## 4. Deployment and Management

### Prerequisites

1.  AWS Account with configured CLI access.
2.  Terraform CLI installed (Ensure version consistency via `terraform.lock.hcl`).
3.  The SSH **Key Pair** named `terraform` must be available in the target region (`us-east-1`).

### Deployment Steps (IaC Workflow)

1.  **Initialize the backend:**
    ```bash
    terraform init
    ```
2.  **Review the execution plan:**
    ```bash
    terraform plan
    ```
3.  **Apply the configuration:**
    ```bash
    terraform apply --auto-approve
    ```

### Post-Deployment: Initial Jenkins Login

1.  **Access:** Navigate to the **Public URL** above to start the Jenkins setup.
2.  **Retrieve Password:** SSH into the instance to fetch the dynamically generated administrator password:
    ```bash
    # Connect to the instance
    ssh -i /path/to/your/terraform.pem ubuntu@98.95.246.89
    
    # Retrieve the secret password
    sudo cat /var/lib/jenkins/secrets/initialAdminPassword
    ```
3.  Use the password to unlock Jenkins in the browser.

### Teardown (Clean Up)

To safely destroy all provisioned AWS resources and prevent recurring charges, use the following command:

```bash
terraform destroy --auto-approve
