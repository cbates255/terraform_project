variable "vpc_cidr" {
  type = string
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
