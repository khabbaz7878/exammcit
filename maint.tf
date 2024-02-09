provider "aws" {
  region = var.aws_region
}

locals {
  instance_ami = "ami-0c55b159cbfafe1f0"
  instance_http_port = 80
}

module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "3.0.0"

  name = "my-vpc"
  cidr = var.vpc_cidr

  azs             = data.aws_availability_zones.available.names
  public_subnets  = var.public_subnet_cidrs
  enable_nat_gateway = true
}

module "ec2_instance" {
  source  = "terraform-aws-modules/ec2-instance/aws"
  version = "3.0.0"

  name = "example-instance"

  ami           = local.instance_ami
  instance_type = var.instance_type
  key_name      = "example-key"

  vpc_security_group_ids = [aws_security_group.instance.id]
  subnet_id = tolist(data.aws_subnet_ids.public.ids)[0]

  user_data = <<-EOF
              #!/bin/bash
              echo "Hello, World!" > index.html
              nohup busybox httpd -f -p "${local.instance_http_port}" &
              EOF
}

data "aws_vpc" "selected" {
  filter {
    name   = "tag:Name"
    values = ["my-vpc"]
  }
}

data "aws_subnet_ids" "public" {
  vpc_id = data.aws_vpc.selected.id

  tags = {
    Tier = "public"
  }
}

resource "aws_security_group" "instance" {
  name_prefix = "example-instance"

  ingress {
    from_port = local.instance_http_port
    to_port   = local.instance_http_port
    protocol  = "tcp"

    cidr_blocks = [
      "0.0.0.0/0",
    ]
  }
}

output "instance_public_ip" {
  value = module.ec2_instance.public_ip
}
