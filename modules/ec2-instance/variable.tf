variable "name" {
  type        = string
  description = "The name of the EC2 instance."
}

variable "ami" {
  type        = string
  description = "The ID of the AMI for the EC2 instance."
}

variable "instance_type" {
  type        = string
  description = "The instance type for the EC2 instance."
}

variable "vpc_id" {
  type        = string
  description = "The ID of the VPC where the subnet is located."
}

variable "subnet_id" {
  type        = string
  description = "The ID of the subnet where the EC2 instance will be launched."
}
