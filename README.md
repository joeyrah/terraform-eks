# terraform-eks

Terraform config for creating an EKS
List of directories and their contents

## vpc
Terraform to create a VPC with a 3 subnets, 2 private and one public

## EKS
Terraform to create an EKS with above VPC with a node group that can have 2-5 workers

## grafana
Commands to install grafana on this EKS using helm charts and then expose it via ELB
