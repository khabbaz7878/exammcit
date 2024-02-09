# EC2 module
module "ec2_instance" {
  source  = "terraform-aws-modules/ec2-instance/aws"

  name = "my-ec2-instance"

  ami                    = "ami-ebd02392" 
  instance_type          = "t2.micro"
  vpc_security_group_ids = [module.vpc.default_security_group_id]
  subnet_id              = module.subnets.public_subnets[0]

  tags = {
    Terraform   = "true"
    Environment = "dev"
  }
}
