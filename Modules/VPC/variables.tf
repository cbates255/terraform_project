variable "vpc_cidr" {
  description = "Cidr block for the VPC"
  type = string
  default = "10.0.0.0/16"
}

variable "publicsubCIDRS" {
  description = "Cidr blocks for the public subnets"
  type = list
  default = ["10.0.1.0/24", "10.0.2.0/24"]
}
