# EKS Landing Zone

A complete production environment for running containerized workloads in AWS, using the Elastic Kubernetes Service (EKS) for orchestratation. 

## Features

- [x] Multi-zone VPC for high availability
- [x] EKS for container orchestration
- [x] ECR for container image storage
- [x] ElastiCache Redis for caching
- [x] Aurora Postgres for data storage
- [ ] CloudFront and WAF for firewalling and rate-limiting
- [ ] Shield Advanced for DDoS protection

## Requirements

- [Terraform](https://terraform.io) 0.14+

## Getting Started

- Clone the repository:
  - `git clone git@github.com:thehouseplant/eks-landing-zone.git`
- Initialize Terraform:
  - `terraform init`
- Validate templates:
  - `terraform validate`
- Show changes applied to current templates:
  - `terraform plan`
- If the changes look good, apply them:
  - `terraform apply`
