



variable "name" {
  type        = string
  description = "Name of the VPC"
}

variable "cidr_block" {
  type        = string
  description = "CIDR block for the VPC"
}

variable "subnet_cidr_block" {
  type        = string
  description = "CIDR block for the public subnet"
}
