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
