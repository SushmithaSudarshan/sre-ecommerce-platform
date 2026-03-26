# Fetch available availability zones in the region
data "aws_availability_zones" "available" {
  state = "available"
}

# Fetch the default VPC (playground provides this)
data "aws_vpc" "default" {
  default = true
}

# Fetch subnets from the default VPC
data "aws_subnets" "default" {
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.default.id]
  }
}

# EKS Cluster
resource "aws_eks_cluster" "ecommerce" {
  name     = var.cluster_name
  role_arn = "arn:aws:iam::${data.aws_caller_identity.current.account_id}:role/eksClusterRole"

  vpc_config {
    subnet_ids = data.aws_subnets.default.ids
  }

  tags = {
    Name    = var.cluster_name
    Project = "sre-ecommerce-platform"
    Phase   = "phase-3"
  }
}

# Fetch current AWS account details (needed for IAM role ARN)
data "aws_caller_identity" "current" {}

# EKS Node Group (the EC2 worker machines)
resource "aws_eks_node_group" "ecommerce_nodes" {
  cluster_name    = aws_eks_cluster.ecommerce.name
  node_group_name = "ecommerce-node-group"
  node_role_arn   = "arn:aws:iam::${data.aws_caller_identity.current.account_id}:role/AmazonEKSNodeRole"
  subnet_ids      = data.aws_subnets.default.ids
  instance_types  = [var.node_instance_type]

  scaling_config {
    desired_size = var.node_desired_count
    min_size     = var.node_min_count
    max_size     = var.node_max_count
  }

  tags = {
    Name    = "ecommerce-node-group"
    Project = "sre-ecommerce-platform"
    Phase   = "phase-3"
  }

  # Node group depends on cluster being fully created first
  depends_on = [aws_eks_cluster.ecommerce]
}