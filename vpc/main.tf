# https://registry.terraform.io/modules/terraform-aws-modules/vpc/aws/latest

provider "aws" {
  region = "us-east-1"
}
module "vpc" {

  source  = "terraform-aws-modules/vpc/aws"
  version = "3.11.0"

  name                    = "joey_exercise"
  cidr                    = "10.0.0.0/16"
  azs                     = ["us-east-1a", "us-east-1b", "us-east-1c"]
  private_subnets         = ["10.0.1.0/24", "10.0.2.0/24"]
  public_subnets          = ["10.0.0.0/24"]
  map_public_ip_on_launch = true
  enable_nat_gateway      = true

  private_subnet_tags = {
    "kubernetes.io/role/internal-elb" = "1"
  }

  public_subnet_tags = {
    "kubernetes.io/role/elb" = "1"
  }

  tags = {
    env        = "practice_exercise"
    created_by = "joey"
  }
}
