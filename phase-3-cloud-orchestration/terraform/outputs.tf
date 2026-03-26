# Cluster details
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

# Command to configure kubectl to talk to the cluster
output "configure_kubectl" {
  description = "Command to connect kubectl to your EKS cluster"
  value       = "aws eks update-kubeconfig --region ${var.aws_region} --name ${var.cluster_name}"
}

# ECR repository URLs (To push images and update manifests)
output "ecr_repository_urls" {
  description = "ECR repository URLs for each microservice"
  value = {
    for repo, details in aws_ecr_repository.microservices :
    repo => details.repository_url
  }
}