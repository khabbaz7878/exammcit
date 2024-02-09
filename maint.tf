module "vpc" {
  source = "./vpc_module"
}

module "ec2" {
  source = "./ec2_module"
  vpc_id = module.vpc.vpc_id
  subnet_id = module.vpc.public_subnet_id
}

resource "aws_vpc" "this" {
  cidr_block = var.cidr_block

  tags = {
    Name = var.vpc_name
  }
}

resource "aws_subnet" "public" {
  count = var.number_of_public_subnets

  cidr_block = cidrsubnet(var.cidr_block, var.new_bit_length, count.index)
  vpc_id     = aws_vpc.this.id

  map_public_ip_on_launch = true

  tags = {
    Name = "${var.vpc_name}-public-subnet-${count.index}"
  }
}

resource "aws_nat_gateway" "this" {
  count = var.create_nat_gateway ? 1 : 0

  allocation_id = aws_eip.nat[0].id
  subnet_id     = aws_subnet.public[0].id

  tags = {
    Name = "${var.vpc_name}-nat-gateway"
  }
}

resource "aws_eip" "nat" {
  count = var.create_nat_gateway ? 1 : 0

  vpc = true

  tags = {
    Name = "${var.vpc_name}-nat-eip"
  }
}

variable "cidr_block" {
  type        = string
  description = "The CIDR block for the VPC."
}

variable "vpc_name" {
  type        = string
  description = "The name of the VPC."
}

variable "number_of_public_subnets" {
  type        = number
  description = "The number of public subnets to create."
  default     = 2
}

variable "new_bit_length" {
  type        = number
  description = "The number of bits to allocate for the subnets."
  default     = 4
}

variable "create_nat_gateway" {
  type        = bool
  description = "Whether to create a NAT gateway."
  default     = true
}

output "vpc_id" {
  value = aws_vpc.this.id
}

output "public_subnet_id" {
  value = aws_subnet.public[0].id
}

resource "aws_instance" "this" {
  ami           = var.ami
  instance_type = var.instance_type
  subnet_id     = var.subnet_id
  key_name      = var.key_name

  vpc_security_group_ids = var.security_groups

  user_data = file("userdata.sh")

  tags = {
    Name = var.instance_name
  }
}

variable "ami" {
  type        = string
  description = "The AMI ID for the EC2 instance."
}

variable "instance_type" {
  type        = string
  description = "The instance type for the EC2 instance."
}

variable "subnet_id" {
  type        = string
  description = "The ID of the subnet where the EC2 instance will be launched."


