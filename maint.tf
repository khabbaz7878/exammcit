module "vpc" {
  source = "./vpc_module"
}

module "ec2" {
  source = "./ec2_module"
  vpc_id = module.vpc.vpc_id
  subnet_id = module.vpc.public_subnet_id
}
