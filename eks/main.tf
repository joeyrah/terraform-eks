provider "aws" {
  region = "us-east-1"
}

data "aws_eks_cluster" "eks" {
  name = module.eks.cluster_id
}

data "aws_eks_cluster_auth" "eks" {
  name = module.eks.cluster_id
}


data "aws_vpc" "eks_vpc" {
  tags = {
    created_by = "joey"
  }
}

data "aws_subnet_ids" "subnet_ids_list" {
  vpc_id = data.aws_vpc.eks_vpc.id
}

provider "kubernetes" {
  host                   = data.aws_eks_cluster.eks.endpoint
  cluster_ca_certificate = base64decode(data.aws_eks_cluster.eks.certificate_authority[0].data)
  token                  = data.aws_eks_cluster_auth.eks.token
}

module "eks" {
  source = "terraform-aws-modules/eks/aws"

  cluster_version = "1.21"
  cluster_name    = "joey_exercise_eks"
  vpc_id          = data.aws_vpc.eks_vpc.id
  subnets         = tolist(data.aws_subnet_ids.subnet_ids_list.ids)

  node_groups = {
    joeys_node_group = {
      desired_capacity = 3
      max_capacity     = 5
      min_capacity     = 3
      capacity_type    = "SPOT"
      instance_types   = ["t2.small"]
      k8s_labels = {
        GithubRepo = "terraform-aws-eks"
        GithubOrg  = "terraform-aws-modules"
      }
    }
  }

  tags = {
    env        = "practice_exercise"
    created_by = "joey"
    name       = "joey_practice_exercise"
  }
}