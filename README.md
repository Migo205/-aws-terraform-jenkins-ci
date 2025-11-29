# AWS Jenkins CI/CD Server Deployment (Terraform IaC)

## 1. Project Overview

This project provides a comprehensive **Infrastructure as Code (IaC)** solution using **Terraform** to provision a secure and fully functional **Jenkins CI/CD Server** on **Amazon Web Services (AWS)**.

The solution ensures a clean, repeatable, and scalable deployment workflow by adhering to best practices:

* **Code Organization:** Resources are split into dedicated files (`network.tf`, `security.tf`, etc.).
* **Parameterization:** All changeable values are managed via **`variables.tf`**.
* **Verification:** Key deployment information is exposed via **`outputs.tf`**.

---

## 2. Solution Architecture

The Terraform configuration provisions the following managed AWS resources:

| Layer | Resources Provisioned | Purpose |
| :--- | :--- | :--- |
| **Networking** | VPC, Public Subnet, Internet Gateway, Route Table | Isolated and managed network environment. |
| **Security** | Security Group (`jenkins_sg`) | Firewall rules allowing inbound traffic on **Port 8080 (Jenkins)** and **Port 22 (SSH)**. |
| **Compute** | EC2 Instance (Ubuntu), Elastic IP (EIP) | Hosts the Jenkins application and provides a stable public access URL. |
| **Application** | Bash Script (`script.sh`) | Automates the installation of Java and the Jenkins service upon instance launch. |

---

## 3. Getting Started

### Prerequisites

1.  AWS Account with configured credentials (CLI profile).
2.  Terraform CLI installed.
3.  The required SSH **Key Pair** (named `terraform`) must exist in your AWS target region.

### Deployment Workflow (Execution)

1.  **Initialize the configuration:**
    ```bash
    terraform init
    ```
2.  **Review the planned changes:**
    ```bash
    terraform plan
    ```
3.  **Apply the infrastructure:**
    ```bash
    terraform apply --auto-approve
    ```

---

## 4. Verification and Access

Upon successful completion, the necessary access details are printed to the console via `outputs.tf`.

### Key Outputs

* **Jenkins Endpoint:** `http://[Jenkins Public IP]:8080` (e.g., `http://98.95.246.89:8080`)
* **EC2 Instance ID:** `i-0bdb7a3460456e2dd`
* **VPC ID:** `vpc-05db7ee8354012a47`
* **SSH Key Name:** `terraform`

### Initial Jenkins Login

1.  **Connect via SSH** to the public IP using your private key:
    ```bash
    ssh -i /path/to/your/terraform.pem ubuntu@<Jenkins Public IP>
    ```
2.  **Retrieve the initial administrator password:**
    ```bash
    sudo cat /var/lib/jenkins/secrets/initialAdminPassword
    ```
3.  Use this password in the browser to unlock the Jenkins console.

---

## 5. Cleanup

To destroy all AWS resources provisioned by this configuration and avoid further billing, execute:

```bash
terraform destroy --auto-approve
