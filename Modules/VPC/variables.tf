variable "vpc_cidr" {
  description = "Cidr block for the VPC"
  type = string
  default = "10.0.0.0/16"
}

variable "region" {
  default = "us-east-1"
}

variable "pubsubCIDRblocks" {
  type = list(string)
}

variable "privsubCIDRblocks" {
  type = list(string)
}

variable "azs" {
  type = list(string)
}