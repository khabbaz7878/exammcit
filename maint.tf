provider "aws" {
  region = var.aws_region
}

locals {
  instance_ami = "ami-0c55b159cbfafe1f0"
  instance_http_port = 80
}

module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "3.0.0"

  name = "my-vpc"
  cidr = var.vpc_cid
