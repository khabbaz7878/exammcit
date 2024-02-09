provider "aws" {
  region = "us-west-2"
}

module "vpc_subnet" {
  source = "./modules/vpc_subnet"

  cidr_block      = "10.0.0.0/16"
  vpc_name        = "my_vpc"
  subnet_cidr_block = "10.0.1.0/24"
  subnet_name      = "my_subnet"
}

module "ec2_instance" {
  source = "./modules/ec2_instance"

  ami             = "ami-0c55b159cbfafe1f0" # This is an example; replace it with the correct AMI ID for your region
  instance_type   = "t2.micro"
  subnet_id       = module.vpc_subnet.subnet_id
  instance_name   = "my_ec2_instance"
}
