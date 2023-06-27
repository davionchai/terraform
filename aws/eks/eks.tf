module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  
  cluster_name    = local.cluster_name
  cluster_version = local.cluster_version

  vpc_id                         = module.vpc.vpc_id
  subnet_ids                     = module.vpc.private_subnets
  cluster_endpoint_public_access = true

  eks_managed_node_group_defaults = {
    ami_type = "AL2_x86_64"

  }

  eks_managed_node_groups = {
    de_airflow_node_group = {
      name = "de-airflow-node-group"
      desired_size = 1
      min_size     = 1
      max_size     = 3

      instance_types = ["m7g.xlarge"]
      disk_size      = 40
      capacity_type  = "ON_DEMAND"
      
      block_device_mappings = {
        xvda = {
          device_name = "/dev/xvda"
          ebs = {
            volume_size           = 40
            volume_type           = "gp3"
            iops                  = 3000
            throughput            = 150
            delete_on_termination = true
          }
        }
      }

    }

    de_superset_node_group = {
      name = "de-superset-node-group"

      instance_types = ["m7g.xlarge"]

      desired_size = 1
      min_size     = 1
      max_size     = 3
    }
  }

  tags = {
    Owner       = "${var.owner_email}"
    Environment = "development"
    ManagedBy   = "Terraform"
  }
  
}
