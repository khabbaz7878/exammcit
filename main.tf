module "vpc" {
  source = "./modules/vpc"

  name               = "my-vpc"
  cidr_block         = "10.0.0.0/16"
  subnet_cidr        =  "10.0.101.0/24"
}
