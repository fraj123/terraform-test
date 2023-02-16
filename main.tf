provider "aws" {
  region       = var.region
  profile      = var.profile
  cluster_name = var.cluster_name
}

data "aws_availability_zones" "available" {}
