variable "region" {
  type        = string
  description = "The AWS Region"
}

variable "cidr_block" {
  type        = string
  description = "The CIDR block for the VPC"
}

variable "cidr_subnet_newbits" {
  type        = number
  description = "Number of bits to allocate for subnet CIDR blocks"
}

variable "number_of_subnets" {
  type        = number
  description = "Number of subnets to create"
}

variable "vpc_name" {
  type        = string
  description = "The name of the VPC"
}
