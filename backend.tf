terraform {
  required_version = ">= 0.13.1"

  required_providers {
    aws   = ">= 4.30.0"
    local = ">= 1.4"
    http = {
      source  = "terraform-aws-modules/http"
      version = ">= 2.4.1"
    }
  }

  # backend "local" {
  # path = "terraform.tfstate"
  # }

  backend "s3" {
    bucket                  = "s3-terraform-tfstate-cogniwide-project"
    key                     = "terraform.tfstate"
    dynamodb_table          = "dynamodb-terraform-tfstate-cogniwide-project"
    region                  = "ap-south-1"
    shared_credentials_file = "~/.aws/credentials"
  }
}

provider "aws" {
  shared_config_files      = ["~/.aws/config"]
  shared_credentials_files = ["~/.aws/credentials"]
}

#############################
#  Fetching vpc repo
#############################
module "terraform-aws-module-vpc" {
  source = "git::https://github.com/terraform-aws-modules/terraform-aws-vpc"
}

#############################
#  Fetching ec2-instance repo
#############################
module "terraform-aws-ec2-instance" {
  source = "git::https://github.com/terraform-aws-modules/terraform-aws-ec2-instance"
}

#############################
#  Fetching s3 repo
#############################
module "terraform-aws-s3-bucket" {
  source = "git::https://github.com/terraform-aws-modules/terraform-aws-s3-bucket"
}

#############################
## Account details
#############################

data "aws_caller_identity" "caller" {}
 