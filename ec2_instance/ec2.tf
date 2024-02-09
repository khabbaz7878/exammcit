variable "vpc_id" {
}

variable "subnet_id" {
}

resource "aws_instance" "example" {
  ami           = "ami-12345678"  # Replace with your AMI ID
  instance_type = "t2.micro"
  subnet_id     = var.subnet_id

  tags = {
    Name = "ExampleInstance"
  }
}
