data "aws_availability_zones" "available" {
    filter {
        name    = "opt-in-status"
        values = ["opt-in-not-required"]
    }
}
locals {
    azs = slice(data.aws_availability_zones.available.names,0,3)
}
// Create of VPC
module "vpc" {
    source = "terraform-aws-modules/vpc/aws"
    version = "~>5.0"
    name = "${var.environment} - vpc"
    cidr = var.vpc_cidr
    azs = local.azs
    public_subnets = [for i in range(length(local.azs)) : cidrsubnet(var.vpc_cidr, 8, i)]
    private_subnets = [for i in range(length(local.azs)) : cidrsubnet(var.vpc_cidr, 8, i + length(local.azs))]
    enable_nat_gateway = true
    single_nat_gateway = true
    public_subnet_tags = {
        "kubernetes.io/role/elb" = "1"
     }   
     private_subnet_tags = {
        "kubernetes.io/role/internal-elb" = "1"
     }
}
// Create of EKS Cluster
module "eks" {
    source = "terraform-aws-modules/eks/aws"
    version = "~>20.31"
    cluster_name = var.cluster_name
    cluster_version = var.cluster_version
    cluster_compute_config = {
        enabled = true
        node_pools = [ "general-purpose" , "system" ]
    }
    vpc_id = module.vpc.vpc_id
    subnet_ids = module.vpc.private_subnets
    cluster_endpoint_private_acess = true
    cluster_endpoint_public_access =true
    authentication_mode = "API"
    cluster_encryption_config = {
        resources = ["secrets"]
    }
    cluster_log_types = ["api" , "audit" , "authenticator" , "controllerManager" , "scheduler"]
    enable_cluster_creator_admin_permissions = true
}
