variable "amazonlinux_ami" {
  default = "ami-026b57f3c383c2eec"
}

variable "pubsubnets" {
  type = string
}


variable "securitygroup" {
  type = set(string)
}

variable "pubsuballid" {
  type = list
}