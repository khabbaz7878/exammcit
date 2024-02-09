resource "aws_vpc" "this" {
  cidr_block = var.cidr_block

  tags = {
    Name = var.vpc_name
  }
}

resource "aws_subnet" "this" {
  vpc_id     = aws_vpc.this.id
  cidr_block = var.subnet_cidr_block

  tags = {
    Name = var.subnet_name
  }
}

output "vpc_id" {
  value       = aws_vpc.this.id
  description = "The ID of the VPC"
}

output "subnet_id" {
  value       = aws_subnet.this.id
  description = "The ID of the subnet"
}
