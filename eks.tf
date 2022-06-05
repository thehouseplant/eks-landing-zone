data "aws_ami" "node_ami" {
  filter {
    name   = "name"
    values = ["amazon-eks-node-${aws_eks_cluster.cluster.version}-v*"]
  }

  most_recent = true
  owners      = ["602401143452"]
}

resource "aws_eks_cluster" "cluster" {
  name                      = "eks-lz-cluster"
  role_arn                  = aws_iam_role.cluster_role.arn
  version                   = var.eks_version
  enabled_cluster_log_types = ["api", "audit"]

  vpc_config {
    security_group_ids      = [aws_security_group.eks_sg.id]
    subnet_ids              = [aws_subnet.private_a.id, aws_subnet.private_b.id, aws_subnet.private_c.id]
    endpoint_private_access = true
    endpoint_public_access  = false
  }

  depends_on = [
    aws_cloudwatch_log_group.eks_logs,
    aws_iam_role_policy_attachment.cluster_AmazonEKSClusterPolicy,
    aws_iam_role_policy_attachment.cluster_AmazonEKSServicePolicy,
    aws_iam_role_policy_attachment.cluster_AmazonEKSVPCResourceController
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

  launch_template {
    id      = aws_launch_template.node.id
    version = "$Latest"
  }

  depends_on = [
    aws_iam_role_policy_attachment.node_AmazonEC2ContainerRegistryReadOnly,
    aws_iam_role_policy_attachment.node_AmazonEC2FullAccess,
    aws_iam_role_policy_attachment.node_AmazonEKS_CNI_Policy,
    aws_iam_role_policy_attachment.node_AmazonEKSWorkerNodePolicy
  ]
}

resource "aws_launch_template" "node" {
  name                   = "${var.prefix}-DEFAULT"
  ebs_optimized          = true
  image_id               = data.aws_ami.node_ami.id
  instance_type          = var.eks_node_size
  vpc_security_group_ids = [aws_security_group.eks_sg.id]
  user_data              = base64encode(local.node-userdata)

  block_device_mappings {
    device_name = "/dev/sda1"

    ebs {
      volume_size = var.eks_node_storage
    }
  }

  capacity_reservation_specification {
    capacity_reservation_preference = "open"
  }

  iam_instance_profile {
    name = aws_iam_instance_profile.node_profile.name
  }

  tags = {
    Name = "EKS Worker Node"
  }
}