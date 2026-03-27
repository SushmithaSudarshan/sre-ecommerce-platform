# Fetch current AWS account details
data "aws_caller_identity" "current" {}

# Fetch default VPC
data "aws_vpc" "default" {
  default = true
}

# Fetch subnets from default VPC
data "aws_subnets" "default" {
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.default.id]
  }
}

# EKS Cluster
# IAM roles (eksClusterRole, AmazonEKSNodeRole) are created manually
# in the AWS console once as foundational infrastructure and referenced here.
# In an automated setup, these would be provisioned via a separate
# Terraform foundation layer.
resource "aws_eks_cluster" "ecommerce" {
  name     = var.cluster_name
  role_arn = "arn:aws:iam::${data.aws_caller_identity.current.account_id}:role/eksClusterRole"

  vpc_config {
    subnet_ids             = data.aws_subnets.default.ids
    endpoint_public_access = true
  }

  tags = {
    Name    = var.cluster_name
    Project = "sre-ecommerce-platform"
    Phase   = "phase-3"
  }
}

# EKS Node Group
resource "aws_eks_node_group" "ecommerce_nodes" {
  cluster_name    = aws_eks_cluster.ecommerce.name
  node_group_name = "ecommerce-node-group"
  node_role_arn   = "arn:aws:iam::${data.aws_caller_identity.current.account_id}:role/AmazonEKSNodeRole"
  subnet_ids      = data.aws_subnets.default.ids
  instance_types  = [var.node_instance_type]
  capacity_type   = "ON_DEMAND"

  scaling_config {
    desired_size = var.node_desired_count
    min_size     = var.node_min_count
    max_size     = var.node_max_count
  }

  labels = {
    role = "worker"
  }

  tags = {
    Name    = "ecommerce-node-group"
    Project = "sre-ecommerce-platform"
    Phase   = "phase-3"
  }

  depends_on = [aws_eks_cluster.ecommerce]
}