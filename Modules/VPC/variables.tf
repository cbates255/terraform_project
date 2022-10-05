variable "vpc_cidr" {
  description = "Cidr block for the VPC"
  type = string
  default = "10.0.0.0/16"
}

variable "region" {
  default = "us-east-1"
}

variable "AZs" {
  type = list(string)
  description = "The AZs housing the subnets"
}

variable "pubsubCIDRblocks" {
  type = list(string)
  description = "Cidr blocks for the public subnets"
}

variable "privsubCIDRblocks" {
  type = list(string)
  description = "Cidr blocks for the private subnets"
}