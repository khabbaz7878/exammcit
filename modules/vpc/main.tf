resource "aws_vpc" "main" {
  cidr_block = var.cidr_block

  tags = {
    Name = var.name
  }
}

resource "aws_subnet" "public" {
  vpc_id     = aws_vpc.main.id
  cidr_block = var.subnet_cidr_block

  tags = {
    Name = "Public Subnet"
  }
}

output "vpc_id" {
  value = aws_vpc.main.id
}

output "subnet_id" {
  value = aws_subnet.public.id
}
