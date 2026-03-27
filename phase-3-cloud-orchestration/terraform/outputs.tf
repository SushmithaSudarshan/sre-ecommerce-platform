output "cluster_name" {
  description = "EKS cluster name"
  value       = aws_eks_cluster.ecommerce.name
}

output "cluster_endpoint" {
  description = "EKS cluster endpoint"
  value       = aws_eks_cluster.ecommerce.endpoint
}

output "cluster_version" {
  description = "Kubernetes version running on the cluster"
  value       = aws_eks_cluster.ecommerce.version
}

output "configure_kubectl" {
  description = "Command to connect kubectl to your EKS cluster"
  value       = "aws eks update-kubeconfig --region ${var.aws_region} --name ${var.cluster_name}"
}