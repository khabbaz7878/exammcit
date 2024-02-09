variable "cidr_block" {
  type        = string
  description = "CIDR block for the VPC"
}

variable "vpc_name" {
  type        = string
  description = "The name of the VPC"
}

variable "subnet_cidr_block" {
  type        = string
  description = "CIDR block for the subnet"
}

variable "subnet_name" {
  type        = string
  description = "The name of the subnet"
}

variable "ami" {
  type        = string
  description = "The ID of the AMI to use for the instance"
}

variable "instance_type" {
  type        = string
  description = "The type of instance to start"
}

variable "subnet_id" {
  type        = string
  description = "The VPC subnet ID where the EC2 instance will be launched"
}

variable "instance_name" {
  type        = string
  description = "The name to give to the EC2 instance"
}
