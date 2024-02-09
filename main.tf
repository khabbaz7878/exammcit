module "vpc" {
  source = "./vpc"

  name               = "my-vpc"
  cidr_block         = "10.0.0.0/16"
}

module "ec2" {
  source = "./ec2-instance"

  name              = "my-ec2-instance"
  ami               = "ami-0c55b159cbfafe1f0"
  instance_type     = "t2.micro"
  vpc_id            = module.vpc.vpc_id
  subnet_id         = aws_subnet.public.id
}

resource "aws_subnet" "public" {
  vpc_id     = module.vpc.vpc_id
  cidr_block = "10.0.1.0/24"

  tags = {
    Name = "Public Subnet"
  }
}
