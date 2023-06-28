module "de-general-vpc" {
  source = "terraform-aws-modules/vpc/aws"

  name             = "de-general-vpc"
  cidr             = "10.0.0.0/16" # 10.0.0.1 - 10.0.255.254
  azs              = slice(data.aws_availability_zones.available.names, 0, 3)
  instance_tenancy = "default"

  private_subnets = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
  public_subnets  = ["10.0.4.0/24", "10.0.5.0/24", "10.0.6.0/24"]

  enable_nat_gateway   = true
  single_nat_gateway   = true
  enable_dns_support   = true
  enable_dns_hostnames = true

  create_database_internet_gateway_route = false
  create_egress_only_igw                 = false
  create_igw                             = true

  public_subnet_tags = {
    "kubernetes.io/cluster/${local.cluster_name}" = "shared"
    "kubernetes.io/role/elb"                      = 1
  }

  private_subnet_tags = {
    "kubernetes.io/cluster/${local.cluster_name}" = "shared"
    "kubernetes.io/role/internal-elb"             = 1
  }

  tags = {
    Owner       = "${var.owner_email}"
    Environment = "development"
    ManagedBy   = "Terraform"
  }
}
