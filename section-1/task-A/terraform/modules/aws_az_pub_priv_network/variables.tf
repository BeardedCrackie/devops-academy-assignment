variable "vpc_id" {
  description = "The VPC ID to create subnets in."
  type        = string
}

variable "public_subnet_cidr" {
  description = "CIDR block for the public subnet."
  type        = string
}

variable "private_subnet_cidr" {
  description = "CIDR block for the private subnet."
  type        = string
}

variable "az" {
  description = "Availability Zone for the subnets."
  type        = string
}

variable "igw_id" {
  description = "Internet Gateway ID for public route."
  type        = string
}
