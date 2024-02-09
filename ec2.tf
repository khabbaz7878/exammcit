data "aws_vpc" "selected" {
  filter {
    name   = "tag:Name"
    values = ["my-vpc"]
  }
}

data "aws_subnet_ids" "public" {
  vpc_id = data.aws_vpc.selected.id

  tags = {
    Tier = "public"
  }
}

resource "aws_instance" "example" {
  ami           = var.instance_ami
  instance_type = var.instance_type
  key_name      = "example-key"
  subnet_id     = tolist(data.aws_subnet_ids.public.ids)[0]

  vpc_security_group_ids = [aws_security_group.instance.id]

  user_data = <<-EOF
              #!/bin/bash
              echo "Hello, World!" > index.html
              nohup busybox httpd -f -p "${var.instance_http_port}" &
              EOF

  tags = {
    Name = "example-instance"
  }
}

resource "aws_security_group" "instance" {
  name_prefix = "example-instance"

  ingress {
    from_port = var.instance_http_port
    to_port   = var.instance_http_port
    protocol  = "tcp"

    cidr_blocks = [
      "0.0.0.0/0",
    ]
  }
}
