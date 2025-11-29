# AWS Jenkins CI/CD Server Deployment (Terraform IaC)

## 1. Project Overview and Philosophy

This repository contains the complete **Terraform** configuration for deploying a robust, secure, and production-ready **Jenkins CI/CD Server** on **Amazon Web Services (AWS)**.

The project embodies the **Infrastructure as Code (IaC)** philosophy by treating the entire environment lifecycle as code, guaranteeing:

* **Repeatability:** The environment can be destroyed and recreated identically in minutes.
* **Consistency:** Eliminates configuration drift across environments.
* **Traceability:** All changes are versioned and audited via Git.

---

## 2. Code Architecture and Structure

The Terraform code is organized into dedicated files, maximizing clarity and modularity:

* **`main.tf`:** Core compute resources (EC2 Instance, Elastic IP) and AWS provider setup.
* **`network.tf`:** Defines the dedicated network boundary (VPC, Subnet, Internet Gateway, Routing).
* **`security.tf`:** Manages the strict Security Group rules for traffic control (Ports 22 & 8080).
* **`variables.tf`:** Centralizes all changeable parameters (Region, Instance Type, AMI ID).
* **`outputs.tf`:** Exposes crucial post-deployment data (Public IP, IDs) to the user.
* **`script.sh`:** The shell script used by `user_data` for automated Jenkins installation and setup.

---

## 3. Deployment Flow (Execution)

### Prerequisites

1.  AWS Account credentials configured for CLI access.
2.  **Terraform CLI** installed.
3.  The necessary SSH **Key Pair** (named `terraform`) must be pre-uploaded to the target AWS Region.

### Steps to Provision

1.  **Initialize the project:**
    ```bash
    terraform init
    ```
2.  **Review the execution plan:**
    ```bash
    terraform plan
    ```
3.  **Apply the infrastructure changes:**
    ```bash
    terraform apply --auto-approve
    ```

---

## 4. Verification and Initial Access

Upon successful deployment, the **`outputs.tf`** file will display all access points.

### Jenkins Access Details

* **Public URL Endpoint:** `http://[Jenkins Public IP]:8080` (e.g., `http://98.95.246.89:8080`)
* **Associated EC2 Instance:** `i-0bdb7a3460456e2dd` (Type: `t2.micro`)

### Initial Login Steps

1.  **Connect Securely via SSH** (using your private key):
    ```bash
    ssh -i /path/to/your/terraform.pem ubuntu@<Jenkins Public IP>
    ```
2.  **Retrieve the Admin Password:** Copy the dynamically generated initial password:
    ```bash
    sudo cat /var/lib/jenkins/secrets/initialAdminPassword
    ```
3.  Use the retrieved password in the browser to complete the Jenkins setup.

---

## 5. Cleanup (Teardown)

To safely destroy **all** AWS resources created by this configuration and avoid ongoing charges:

```bash
terraform destroy --auto-approve
