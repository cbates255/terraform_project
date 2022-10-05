
#VPC resource
resource "aws_vpc" "projectVPC" {
  cidr_block = var.vpc_cidr
}

#Public subnets resource
resource "aws_subnet" "pubsub" {
  vpc_id = aws_vpc.projectVPC.id
  count = 2
  availability_zone = data.aws_availability_zones.availableAZS.names[count.index]
  map_public_ip_on_launch = true
  cidr_block = var
}

#Private subnets resource
resource "aws_subnet" "privsub" {
  vpc_id = aws_vpc.projectVPC.id
  count = length(var.AZs)
  availability_zone = 
  map_public_ip_on_launch = false
  cidr_block = 
}