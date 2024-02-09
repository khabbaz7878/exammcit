provider "aws" {
  region = var.region
}

resource "aws_vpc" "this" {
  cidr_block = var.cidr_block

  tags = {
    Name = var.vpc_name
  }
}

resource "aws_subnet" "public" {
  count = var.number_of_subnets

  cidr_block = cidrsubnet(var.cidr_block, var.cidr_subnet_newbits, count.index)
  vpc_id     = aws_vpc.this.id
  map_public_ip_on_launch = true

  tags = {
    Name = "${var.vpc_name}-public-${count.index}"
  }
}

output "vpc_id" {
  value = aws_vpc.this.id
}

output "subnet_ids" {
  value = aws_subnet.public.*.id
}
