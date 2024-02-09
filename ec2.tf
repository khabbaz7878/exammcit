# ec2_instance_module/main.tf

resource "aws_instance" "my_instance" {
  ami           = "ami-12345678"  # Replace with your desired AMI
  instance_type = "t2.micro"
  subnet_id     = var.subnet_id   # Using subnet_id from input variables
  # Add other instance configurations as needed
}
