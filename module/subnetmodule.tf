# Subnet module
module "subnets" {
  source = "terraform-aws-modules/subnets/aws"

  vpc_id = module.vpc.vpc_id

  subnets = {
    public = [
      {
        name = "public-1"
        cidr = "10.0.101.0/24"
        az   = "us-east-1a"
      },
      {
        name = "public-2"
        cidr = "10.0.102.0/24"
        az   = "us-east-1b"
      },
    ]
    private = []
  }

  tags = {
    Terraform = "true"
    Environment = "dev" 
  }
}
