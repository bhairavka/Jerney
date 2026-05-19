output "cluster_endpoint" {
    description = "The endpoint of the EKS cluster"
    value       = module.eks.cluster_eks_endpoint
}
output "cluster_name" {
    description = "The name of the EKS cluster"
    value      = module.eks.cluster_name
}
output "vpc_id" {
    description = "The ID of the VPC"
    value       = module.vpc.vpc_id
    }
output "public_subnets" {
    description = "The IDs of the public subnets"
    value       = module.vpc.public_subnets
}
output "private_subnets" {
    description = "The IDs of the private subnets"
    value       = module.vpc.private_subnets
}
output "cluster_certificate_authority" {
  description = "EKS cluster CA certificate (base64)"
  value       = module.eks.cluster_certificate_authority_data
  sensitive   = true
}
output "aws-region" {
    description = "The AWS region where the resources are deployed"
    value       = var.aws_region
}