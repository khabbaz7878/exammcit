# main.tf

module "my_vpc" {
  source = "./vpc_module"
  # Add any input variables for VPC module if needed
}

module "my_ec2_instance" {
  source    = "./ec2_instance_module"
  subnet_id = module.my_vpc.subnet_a_id  # Pass the subnet ID from VPC module output
  # Add any other input variables for EC2 module if needed
}
