variable "name" {
  type        = string
  description = "The name of the VPC."
}

variable "cidr_block" {
  type        = string
  description = "The CIDR block for the VPC."
}

variable "subnet_cidr_block" {
  type        = string
  description = "The CIDR block for the subnet."
}

variable "subnet_name" {
  type        = string
  description = "The name of the subnet."
}
