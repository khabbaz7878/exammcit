# vpc.tf

resource "aws_vpc" "this" {
  cidr_block = var.cidr_block

  tags = {
    Name = var.name
  }
}

output "vpc_id" {
  value = aws_vpc.this.id
}

output "cidr_block" {
  value = aws_vpc.this.cidr_block
}

variable "name" {
  description = "The name of the VPC"
  type        = string
}

variable "cidr_block" {
  description = "The CIDR block for the VPC"
  type        = string
}
