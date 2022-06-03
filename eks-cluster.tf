module "eks" {
  source          = "terraform-aws-modules/eks/aws"
  version         = "17.24.0"
  cluster_name    = "EKS-CLUSTER-TEST"
  cluster_version = "1.20"
  subnets         = module.vpc.private_subnets

  vpc_id = module.vpc.vpc_id

  workers_group_defaults = {
    root_volume_type = "gp3"
  }

  worker_groups = [
    {
      name                          = "EKS-WORKERS-1"
      instance_type                 = "t3.small"
      additional_userdata           = "echo Hello World!"
      additional_security_group_ids = []
      asg_desired_capacity          = 3
    },
    {
      name                          = "EKS-WORKERS-2"
      instance_type                 = "t3.small"
      additional_userdata           = "echo Hello World!"
      additional_security_group_ids = []
      asg_desired_capacity          = 3
    }
  ]
}

data "aws_eks_cluster" "cluster" {
  name = module.eks.cluster_id
}

data "aws_eks_cluster_auth" "cluster" {
  name = module.eks.cluster_id
}
