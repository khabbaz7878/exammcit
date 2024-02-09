# VPC module (vpc/main.tf)

resource "aws_vpc" "myapp_vpc" {
  cidr_block = "10.0.0.0/16"
}

resource "aws_subnet" "myapp_subnet_1" {
  vpc_id = aws_vpc.myapp_vpc.id
  cidr_block = "10.0.1.0/24"
}

output "vpc_id" {
  value = aws_vpc.myapp_vpc.id
}

output "subnet_id" {
  value = aws_subnet.myapp_subnet_1.id
}

# EC2 module (ec2/main.tf) 

variable "vpc_id" {}

variable "subnet_id" {}

resource "aws_instance" "myapp_server" {
  ami           = "ami-0c55b159cbfafe1f0" 
  instance_type = "t2.micro"
  subnet_id     = var.subnet_id

  vpc_security_group_ids = [aws_security_group.myapp_sg.id] 
}

resource "aws_security_group" "myapp_sg" {
  vpc_id = var.vpc_id

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] 
  }
}

# Root module (main.tf)

module "vpc" {
  source = "./vpc"
}

module "ec2" {
  source    = "./ec2"
  vpc_id    = module.vpc.vpc_id
  subnet_id = module.vpc.subnet_id
}
