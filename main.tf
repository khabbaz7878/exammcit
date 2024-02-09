# main.tf

module "vpc" {
  source = "./modules/vpc"

  name       = "example-vpc"
  cidr_block = "10.0.0.0/16"
}

module "ec2" {
  source = "./modules/ec2"

  name              = "example-ec2"
  ami               = "ami-12345678"
  instance_type     = "t2.micro"
  instance_name     = "example-ec2"
  subnet_id         = module.vpc.subnet_id
  vpc_id            = module.vpc.vpc_id
}
