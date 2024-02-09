provider "aws" {
  region = var.region
}

resource "aws_instance" "this" {
  ami           = var.ami_id
  instance_type = var.instance_type
  subnet_id     = element(var.subnet_ids, var.subnet_index)
  key_name      = var.key_name

  vpc_security_group_ids = [aws_security_group.this.id]

  tags = {
    Name = "ec2-instance-${var.subnet_index}"
  }
}

resource "aws_security_group" "this" {
  name        = "ec2-instance-sg"
  description = "Security group for EC2 instance"
  vpc_id      = element(var.vpc_ids, var.vpc_index)

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

output "instance_id" {
  value = aws_instance.this.id
}

output "instance_public_ip" {
  value = aws_instance.this.public_ip
}
