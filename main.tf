module "vpc" {
  source               = "./vpc"
  vpc_cidr             = "10.0.0.0/16"
  public_subnet_cidr   = "10.0.1.0/24"
  private_subnet_cidr  = "10.0.2.0/24"
}

module "ec2_instance" {
  source        = "./ec2"
  ami           = "your-ami-id"
  instance_type = "t2.micro"
  subnet_id     = module.vpc.public_subnet_ids[0] // Choose one of the public subnets
}
