resource "aws_eks_cluster" "cluster" {
  name     = "EKS-TEST"
  role_arn = aws_iam_role.cluster_role.arn
  version  = var.eks_version

  vpc_config {
    security_group_ids = [aws_security_group.eks_sg.id]
    subnet_ids         = [aws_subnet.private_a.id, aws_subnet.private_b.id, aws_subnet.private_c.id]
  }

  depends_on = [
    aws_iam_role_policy_attachment.cluster_policy_attachment
  ]
}

resource "aws_eks_node_group" "node" {
  cluster_name    = aws_eks_cluster.cluster.name
  node_group_name = "EKS-TEST-1"
  node_role_arn   = aws_iam_role.nodes_role.arn
  subnet_ids      = [aws_subnet.private_a.id, aws_subnet.private_b.id, aws_subnet.private_c.id]

  scaling_config {
    desired_size = var.eks_node_desired
    max_size     = var.eks_node_max
    min_size     = var.eks_node_min
  }

  depends_on = [
    aws_iam_role_policy_attachment.AmazonEKSWorkerNodePolicy,
    aws_iam_role_policy_attachment.AmazonEKS_CNI_Policy,
    aws_iam_role_policy_attachment.AmazonEC2ContainerRegistryReadOnly
  ]
}