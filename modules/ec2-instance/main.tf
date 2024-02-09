data "aws_vpc" "selected" {
  id = var.vpc_id
}

resource "aws_instance" "instance" {
  ami           = var.ami
  instance_type = var.instance_type
  subnet_id     = var.subnet_id

  vpc_security_group_ids = [aws_security_group.instance.id]

  user_data = file("install-httpd.sh")

  tags = {
    Name = var.instance_name
  }
}

resource "aws_security_group" "instance" {
  name_prefix = var.instance_name
  description = "Security group for the EC2 instance"
  vpc_id      = data.aws_vpc.selected.id

  ingress {
    from_port   = 80
    to_port     = 80
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
  value = aws_instance.instance.id
}

output "instance_public_ip" {
  value = aws_instance.instance.public_ip
}
