# EKS Test

A test environment for greenfield container image deployments using AWS Elastic Kubernetes Service (EKS)

## Requirements

- [Terraform](https://terraform.io) 0.14+

## Getting Started

- Clone the repository:
  - `git clone git@github.com:thehouseplant/ecs-test.git`
- Initialize Terraform:
  - `terraform init`
- Validate templates:
  - `terraform validate`
- Show changes applied to current termplates:
  - `terraform plan`
- If the changes look good, apply them:
  - `terraform apply`
