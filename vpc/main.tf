# https://registry.terraform.io/modules/terraform-aws-modules/vpc/aws/latest

provider "aws" {
  region = "us-east-1"
}
module "vpc" {
  source = "terraform-aws-modules/vpc/aws"

  name = "joey_exercise"
  cidr = "10.0.0.0/16"

  azs             = ["us-east-1a", "us-east-1b"]
  private_subnets = ["10.0.1.0/24"]
  public_subnets  = ["10.0.0.0/24"]

  enable_nat_gateway = true

  tags = {
    env        = "practice_exercise"
    created_by = "joey"
  }
}
