module "vpc" {
  source = "./modules/vpc"

  name               = "my-vpc"
  cidr_block         = "10.0.0.0/16"
  subnet_cidr_block  = "10.0.1.0/24"
}

module "ec2-instance" {
  source = "./modules/ec2-instance"

  instance_name   = "my-ec2-instance"
  ami             = "ami-0c55b159cbfafe1f0" # Replace this
