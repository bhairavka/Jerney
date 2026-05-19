variable "aws_region" {
    description = "The aws region where the resources are deployed"
    type        = string
    default     = "us-east-1"       
}
variable "environment" {
    description = "The environment where the resources are deployed"
    type        = string
    default     = "dev"
}
variable "vpc_cidr" {
    description = "The CIDR block for the VPC"
    type        = string
    default     = "10.0.0.0/16"
}
variable "cluster_name" {
    description = "The name of the EKS cluster"
    type        = string
    default     = "jerney_eks_cluster"
}
variable  "cluster_version" {
    description = "The Kubernetes version for the EKS cluster"
    type        = string
    default     = "1.32"
}