variable "db_name" {
  type = string
}

variable "db_engine" {
  type = string
}

variable "db_instanceclass" {
  type = string
}

variable "dbuser" {
  type = string
}

variable "dbpass" {
  type = string
  sensitive = true
}

variable "zone1" {
  type = string
  default = "us-east-1a"
}

variable "privsubid" {
  
}

variable "securitygroup" {
  
}