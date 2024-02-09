# vpc_module/main.tf

resource "aws_vpc" "my_vpc" {
  cidr_block = "10.0.0.0/16"
  # Add other VPC configurations as needed
}

resource "aws_subnet" "subnet_a" {
  vpc_id            = aws_vpc.my_vpc.id
  cidr_block        = "10.0.1.0/24"
  availability_zone = "us-east-1a"
  # Add other subnet configurations as needed
}

# Add more subnets as needed
