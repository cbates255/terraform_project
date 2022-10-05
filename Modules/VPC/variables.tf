variable "vpc_cidr" {
  description = "Cidr block for the VPC"
  type = string
  default = "10.0.0.0/16"
}

variable "region" {
  default = "us-east-1"
}

variable "AZs" {
  type = list
  description = "The AZs housing the subnets"
  default = [ "us-east-1a", "us-east-1b" ]
}

variable "pubsubCIDRblocks" {
  type = list
  description = "Cidr blocks for the public subnets"
}

variable "privsubCIDRblocks" {
  type = list
  description = "Cidr blocks for the private subnets"
}