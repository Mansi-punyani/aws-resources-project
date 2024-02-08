module "eks" {
  source  = "git::https://github.com/terraform-aws-modules/terraform-aws-eks"

  cluster_name    = "${var.environment}-eks-cluster"
  cluster_version = "1.29"

  cluster_endpoint_public_access  = false

  cluster_addons = {
  coredns = {
  most_recent = true
  }
  kube-proxy = {
  most_recent = true
  }
  vpc-cni = {
  most_recent = true
  }
  }

  vpc_id                   =  module.vpc-b.vpc_id
  subnet_ids               = [module.vpc-b.private_subnets[0], module.vpc-b.private_subnets[3]]
  control_plane_subnet_ids = [module.vpc-b.private_subnets[0], module.vpc-b.private_subnets[3]]

  EKS Managed Node Group(s)
  eks_managed_node_group_defaults = {
  instance_types = ["t3.micro"]
  }

  eks_managed_node_groups = {
    example = {
     min_size     = 1
      max_size     = 1
      desired_size = 1

      instance_types = ["t3.micro"]
    }
  }

  Cluster access entry
  To add the current caller identity as an administrator
  enable_cluster_creator_admin_permissions = true

  tags = local.tags

}