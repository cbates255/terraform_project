#Pull the available AZs
data "aws_availability_zones" "azs" {
  state = "available"
}

#Create the vpc
resource "aws_vpc" "projectVPC" {
  cidr_block = var.vpc_cidr
}

#Create 2 public subnets split across AZs
resource "aws_subnet" "pubsub" {
  vpc_id = aws_vpc.projectVPC.id
  count = 2
  availability_zone = data.aws_availability_zones.azs.names[count.index]
  
}


#Create 2 private subnets split across AZs
