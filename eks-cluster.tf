data "aws_ami" "node_ami" {
  filter {
    name   = "name"
    values = ["amazon-eks-node-${aws_eks_cluster.cluster.version}-v*"]
  }

  most_recent = true
  owners      = ["602401143452"]
}

resource "aws_eks_cluster" "cluster" {
  name     = "${var.prefix}-CLUSTER"
  role_arn = aws_iam_role.cluster_role.arn
  version  = var.eks_version

  vpc_config {
    security_group_ids      = [aws_security_group.eks_sg.id]
    subnet_ids              = [aws_subnet.private_a.id, aws_subnet.private_b.id, aws_subnet.private_c.id]
    endpoint_private_access = true
    endpoint_public_access  = false
  }

  depends_on = [
    aws_iam_role_policy_attachment.cluster_AmazonEKSClusterPolicy,
    aws_iam_role_policy_attachment.cluster_AmazonEKSServicePolicy
  ]
}

resource "aws_eks_node_group" "node" {
  cluster_name    = aws_eks_cluster.cluster.name
  node_group_name = "${var.prefix}-1"
  node_role_arn   = aws_iam_role.nodes_role.arn
  subnet_ids      = [aws_subnet.private_a.id, aws_subnet.private_b.id, aws_subnet.private_c.id]

  scaling_config {
    desired_size = var.eks_node_desired
    max_size     = var.eks_node_max
    min_size     = var.eks_node_min
  }

  depends_on = [
    aws_iam_role_policy_attachment.node_AmazonEC2ContainerRegistryReadOnly,
    aws_iam_role_policy_attachment.node_AmazonEC2FullAccess,
    aws_iam_role_policy_attachment.node_AmazonEKS_CNI_Policy,
    aws_iam_role_policy_attachment.node_AmazonEKSWorkerNodePolicy
  ]
}

resource "aws_launch_configuration" "node" {
  iam_instance_profile = aws_iam_instance_profile.node_profile
  image_id             = data.aws_ami.node_ami.id
  instance_type        = var.eks_node_size
  name_prefix          = "${var.prefix}-NODE"
  security_groups      = [aws_security_group.eks_sg.id]
  user_data_base64     = base64encode(local.node-userdata)

  lifecycle {
    create_before_destroy = true
  }
}