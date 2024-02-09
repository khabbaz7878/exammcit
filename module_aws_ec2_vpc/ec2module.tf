module "ec2_instance" {
  source  = "terraform-aws-modules/ec2-instance/aws"
  version = "2.0.0"

  name = "my-ec2-instance"

  ami           = "ami-0c94855ba95c574c8"
  instance_type = "t2.micro"
  key_name      = "my-key-pair"

  vpc_security_group_ids = [module.vpc.security_group_id]
  subnet_id              = module.vpc.public_subnets[0]

  tags = {
    Environment = "test"
  }
}
