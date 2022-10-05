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

#copy paste for module
#vpc_cidr =
#pubsubCIDRblocks = 
#privsubCIDRblocks = 
#azs = 