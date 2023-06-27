provider "aws" {
  region  = var.region
}

locals {
  cluster_name = "de-general-eks"
  cluster_version = "1.27"

  private_subnet_ids = [
  ]

  public_subnet_ids = [
  ]
  eks_subnet_ids = concat(local.public_subnet_ids, local.private_subnet_ids)
}

data "aws_vpc" "de_general_vpc" {
  filter {
    name   = "name"
    values = ["de-general-vpc"]
  }
}

data "aws_ami" "worker" {
  filter {
    name   = "name"
    values = ["amazon-eks-node-${local.cluster_version}-v*"]
  }
  most_recent = true
  # Amazon EKS AMI Account ID
  owners      = ["X"] 
}

# https://aws.amazon.com/blogs/containers/amazon-ebs-csi-driver-is-now-generally-available-in-amazon-eks-add-ons/ 
data "aws_iam_policy" "ebs_csi_policy" {
  arn = "arn:aws:iam::aws:policy/service-role/AmazonEBSCSIDriverPolicy"
}

data "aws_security_groups" "example_sg" {
  filter {
    name   = "vpc-id"
    values = []
  }

  filter {
    name   = "tag:Example"
    values = ["Example"]
  }

  filter {
    name   = "tag:Example2"
    values = ["Example2"]
  }
}

