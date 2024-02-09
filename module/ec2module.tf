resource "aws_instance" "this" {
  ami           = var.ami
  instance_type = var.instance_type
  subnet_id     = var.subnet_id

  tags = {
    Name = var.instance_name
  }
}

output "instance_id" {
  value       = aws_instance.this.id
  description = "The ID of the EC2 instance"
}
