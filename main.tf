# VPC module
module "vpc" {
  source = "terraform-aws-modules/vpc/aws"

  name = "my-vpc"
  cidr = "10.0.0.0/16"

  azs             = ["us-east-1a", "us-east-1b", "us-east-1c"]
  private_subnets = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
  public_subnets  = ["10.0.101.0/24", "10.0.102.0/24", "10.0.103.0/24"]

  tags = {
    Terraform = "true"
    Environment = "dev"
  }
}

# Public subnets
resource "aws_subnet" "public" {
  vpc_id = module.vpc.vpc_id
  cidr_block = "10.0.101.0/24"
  availability_zone = "us-east-1a"

  tags = {
    Name = "Public subnet 1"
  }
}

# EC2 instance
module "ec2_instance" {
  source  = "terraform-aws-modules/ec2-instance/aws"

  name = "my-ec2-instance"

  ami                    = "ami-ebd02392"
  instance_type          = "t2.micro" 
  vpc_security_group_ids = [module.vpc.default_security_group_id]
  subnet_id              = aws_subnet.public.id

  tags = {
    Terraform   = "true"
    Environment = "dev" 
  }
}
