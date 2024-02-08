module "vpc-a" {
  # source = "terraform-aws-modules/vpc/aws"
  source = "./.terraform/modules/terraform-aws-module-vpc"

  name = "${var.environment}-vpc-a"
  cidr = "10.0.0.0/16"

  # azs             = ["ap-south-1a", "ap-south-1b", "ap-south-1c"]
  azs             = ["ap-south-1a"]
  private_subnets = ["10.0.1.0/24"]
  private_subnet_names = ["subnet-b"]
  public_subnets  = ["10.0.101.0/24"]
  public_subnet_names = ["subnet-a"]


  enable_nat_gateway = true
  single_nat_gateway = true
  one_nat_gateway_per_az = false

  enable_vpn_gateway = false

  tags = local.tags

}

module "vpc-b" {
    # source = "terraform-aws-modules/vpc/aws"
  source = "./.terraform/modules/terraform-aws-module-vpc"

  name = "${var.environment}-vpc-b"
  cidr = "10.1.0.0/16"

  azs             = ["ap-south-1a", "ap-south-1b"]
  private_subnets = ["10.1.0.0/19", "10.1.32.0/19", "10.1.64.0/19", "10.1.96.0/19", "10.1.128.0/19", "10.1.160.0/19"]
  private_subnet_names = ["subnet-c-1a", "subnet-db-a-1a", "subnet-db-b-1a","subnet-c-1b", "subnet-db-a-1b", "subnet-db-b-1b"]

  # public_subnets  = ["10.1.101.0/24", "10.1.102.0/24", "10.1.103.0/24"]

  enable_nat_gateway = false
  single_nat_gateway = false
  one_nat_gateway_per_az = false

  enable_vpn_gateway = false

  tags = local.tags

}