variable "vpc_cidr" {
  description = "Cidr block for the VPC"
  type = string
  default = "10.0.0.0/16"
}

variable "region" {
  default = "us-east-1"
}

variable "number_of_public_subnets" {
  default = 2
}

variable "number_of_private_subnets" {
  default = 2
}

variable "AZs" {
  type = list(string)
  description = "The AZs housing the subnets"
}