data "aws_availability_zones" "available" {}

locals {
  region       = var.aws_region
   local_names = [
    for name in var.local_name :
    "${name}-${var.local_env.env}"
  ]

  bucket         = var.bucket
  vpc_cidr       = var.vpc_cidr_block
  azs            = slice(data.aws_availability_zones.available.names, 0, var.vpc_subnets_count)
  instance_types = ["t3.small"]

  tags = {
    Terraform = "true",
    Name      = var.local_name[0],
    Env       = var.local_env.env
  }
}
