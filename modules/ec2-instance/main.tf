data "aws_vpc" "this" {
  id = var.vpc_id
}

resource "aws_instance" "this" {
  ami           = var.ami
  instance_type = var.instance_type
  subnet_id     = var.subnet_id

  vpc_security_group_ids = [aws_security_group.instance.id]

  tags = {
    Name = var.name
  }
}

resource "aws_security_group" "instance" {
  name_prefix = var.name
  description = "Security group for the EC2 instance."
  vpc_id      = data.aws_vpc.this.id

  ingress {
    from_port = 22
    to_port   = 22
    protocol  = "tcp"
    cidr_blocks = [
      "0.0.0.0/0"
    ]
  }

  egress {
    from_port = 0
    to_port   = 0
    protocol  = "-1"
    cidr_blocks = [
      "0.0.0.0/0"
    ]
  }
}
