module "ec2-vm-public-a" {
  source = "./.terraform/modules/terraform-aws-ec2-instance"

  name = "${var.environment}-vm-public-a"

  subnet_id              = module.vpc-a.public_subnets[0]
  vpc_security_group_ids = [module.vpc-a.default_security_group_id]
  ami                    = "ami-0d63de463e6604d0a"
  instance_type          = "t3.micro"
  key_name               = module.ssh_keys_vpc_a.ssh_keys["id_rsa"]

  user_data_base64            = base64encode(local.user_data)
  user_data_replace_on_change = true
  associate_public_ip_address  = true

  create_iam_instance_profile = true
  iam_role_description        = "IAM role for EC2 instance"
  iam_role_policies = {
    AmazonSSMManagedInstanceCore = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
  }

  tags = local.tags
}

module "ec2-vm-private-a" {
  source = "./.terraform/modules/terraform-aws-ec2-instance"

  name = "${var.environment}-vm-private-a"

  subnet_id              = module.vpc-a.private_subnets[0]
  vpc_security_group_ids = [module.vpc-a.default_security_group_id]
  ami                    = "ami-0d63de463e6604d0a"
  instance_type          = "t3.micro"

  create_iam_instance_profile = true
  iam_role_description        = "IAM role for EC2 instance"
  iam_role_policies = {
    AmazonSSMManagedInstanceCore = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
  }

  tags = local.tags
}

module "ec2-vm-private-b" {
  source = "./.terraform/modules/terraform-aws-ec2-instance"

  name = "${var.environment}-vm-private-b"

  subnet_id              = module.vpc-b.private_subnets[0]
  vpc_security_group_ids = [module.vpc-b.default_security_group_id]
  ami                    = "ami-0d63de463e6604d0a"
  instance_type          = "t3.micro"

  create_iam_instance_profile = true
  iam_role_description        = "IAM role for EC2 instance"
  iam_role_policies = {
    AmazonSSMManagedInstanceCore = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
  }

  tags = local.tags
}

module "ec2-vm-private-c" {
  source = "./.terraform/modules/terraform-aws-ec2-instance"

  name = "${var.environment}-vm-private-c"

  subnet_id              = module.vpc-b.private_subnets[0]
  vpc_security_group_ids = [module.vpc-b.default_security_group_id]
  ami                    = "ami-0d63de463e6604d0a"
  instance_type          = "t3.micro"

  create_iam_instance_profile = true
  iam_role_description        = "IAM role for EC2 instance"
  iam_role_policies = {
    AmazonSSMManagedInstanceCore = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
  }

  tags = local.tags
}
